class Game < ActiveRecord::Base

  include Tokenable
  tokenable_by 6

  # Associations
  has_one :session
  has_and_belongs_to_many :questions, through: :games_questions

  # Validations
  validates :user_id, presence: true # ever game must belong to a user

  def ensure_only_one_active_game
    # do stuff to ensure a user have only one active game (place holder for game status implementation)
  end

  def new_question(level)
    question = loop do
      qq = Question::random_question(level)
      raise "Could not retrieve a random question. Questions db might be empty!" if qq.nil?
      break qq unless questions.include? qq  # find a unique question for our game
    end

    questions << question
    question
  end

  def user_answered(question_id, answer_ids)
    if user_correct?(question_id, answer_ids)
      update(answered_correctly: +1)
      true
    else
      false
    end
  end

  def questions_count
    questions.count
  end

  def user_correct?(question_id, answer_ids)
    question, answers = Question.find(question_id), Answer.find(answer_ids)
    question.corrects == answers
  end

  def name
    "Game ##{token}"
  end
end