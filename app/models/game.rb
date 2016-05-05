class Game < ActiveRecord::Base

  include Tokenable
  tokenable_by 6

  GAME_PASS_THRESHOLD   = 10
  CATEGORIES_IN_GAME    = 5
  QUESTIONS_IN_CATEGORY = 2

  # Associations
  has_and_belongs_to_many :questions, through: :games_questions
  has_many :categories, through: :categories_game
  has_many :categories_game

  # Validations
  validates :user_id, presence: true # ever game must belong to a user

  def self.create_new_game(user_id)
    game = Game.new user_id: user_id
    loop do 
      category = Category::random
      game.categories << category unless game.categories.include? category

      break if game.categories.size >= CATEGORIES_IN_GAME
    end
    game.save!

    game
  end

  def new_question(category)
    
    # choose the next question for the user
    # if question is new in game or if there are no other questions in specified category
    question = loop do 
      qq = Question.where(category: category).sample      
      break qq if (questions.exclude? qq) || (Question.where(category: category).count <= questions.where(category: category).count)
    end

    # add the question to the game questions pool if needed
    questions << question unless questions.include? question

    question
  end

  def user_answered(question_id, answer_ids)
    if user_correct?(question_id, answer_ids)
      category = Question.find(question_id).category      
      categories_game.find_by(category: category).answered_correctly

      true
    else
      false
    end
  end

  def completed?
    categories_game.each do |cg|
      return false if cg.completed? == false
    end

    true
  end

  def questions_count
    questions.count
  end

  def answered_correctly
    sum = 0
    categories_game.each do |cg|
      sum += cg.corrects
    end
    sum
  end

  def user_correct?(question_id, answer_ids)
    question, answers = Question.find(question_id), Answer.find(answer_ids)
    question.corrects == answers
  end

  def name
    "Game ##{token}"
  end
end