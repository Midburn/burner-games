class Game < ActiveRecord::Base

  include Tokenable
  tokenable_by 6

  GAME_PASS_THRESHOLD = 10
  CATEGORIES_SIZE = 5
  QUESTIONS_IN_CATEGORY = 2

  # Associations
  has_and_belongs_to_many :questions, through: :games_questions

  # Validations
  validates :user_id, presence: true # ever game must belong to a user

  def self.create_new_game(user_id)
    game = Game.new user_id: user_id
    game.categories = Question::random_categories(CATEGORIES_SIZE)
    game.save!

    game
  end

  def ensure_only_one_active_game
    # do stuff to ensure a user have only one active game (place holder for game status implementation)
  end

  def new_question(category)

    # if no new question is available
    if Question.where(category: Question.categories[category]).count <= questions.where(category: Question.categories[category]).count
      question = questions.where(category: Question.categories[category]).sample
    else    
      question = loop do
        qq = Question::random_question(category)
        
        # prefer a unique question for our game
        break qq unless questions.include? qq
      end

      questions << question unless question.nil?
    end

    question
  end

  def user_answered(question_id, answer_ids)
    if user_correct?(question_id, answer_ids)
      update_attribute(:answered_correctly, answered_correctly + 1)
      true
    else
      false
    end
  end

  def game_ended?
    answered_correctly > GAME_PASS_THRESHOLD
  end

  def questions_count
    questions.count
  end

  def user_correct?(question_id, answer_ids)
    question, answers = Question.find(question_id), Answer.find(answer_ids)
    question.corrects == answers
  end

  def games_categories
    JSON.parse(categories)
  end

  def name
    "Game ##{token}"
  end
end