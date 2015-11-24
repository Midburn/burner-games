class Game < ActiveRecord::Base

  include Tokenable
  tokenable_by 6

  # Associations
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

  def name
    "Game ##{token}"
  end
end