class Question < ActiveRecord::Base

  # enums
  enum question_type: { text: 0, image: 1, video: 2 }
  enum category: {  other: 0, inclusion: 1, gifting: 2, decommodification: 3, radical_self_reliance: 4,
                    radical_self_expression: 5, communal_effort: 6, civic_responsibility: 7,
                    leaving_no_trace: 8, participation: 9, immediacy: 10 }
  enum level: { easy: 0, very_hard: 100 }

  # Associations
  has_many :user_answers, dependent: :destroy
  has_many :answers, through: :user_answers, dependent: :destroy
  has_and_belongs_to_many :games, through: :games_questions

  # Validations
  validates :body, presence: true
  validates :body, url: true, if: -> { question_type != "text" }
  validates :question_type, presence: true

  # scopes
  scope :easy,      -> { where level: 0 }
  scope :very_hard, -> { where level: 100 }

  def self.random_question(level)
    case level
    when "easy"
      Question.easy.sample
    when "very_hard"
      Question.very_hard.sample
    end
  end

  def corrects
    user_answers.where(correct: true)
  end

  def falses
    user_answers.where(correct: false)
  end

  def mark_correct_answer(given_answer)
    raise "Can not mark answer as correct, as it's not assosiated with this question" if answers.exclude?(given_answer)
    user_answers.find_by_answer_id(given_answer.id).update(correct: true)
  end

  def name
    case question_type
    when "text"
      "Text: #{body}"
    when "Image"
      "Image: ##{id}"
    when "Video"
      "Video: ##{id}"
    end
  end
end
