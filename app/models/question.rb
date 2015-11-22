class Question < ActiveRecord::Base

  enum question_type: { text: 0, image: 1, video: 2 }
  enum category: {  other: 0, inclusion: 1, gifting: 2, decommodification: 3, radical_self_reliance: 4,
                    radical_self_expression: 5, communal_effort: 6, civic_responsibility: 7,
                    leaving_no_trace: 8, participation: 9, immediacy: 10 }

  # Associations
  has_many :user_answers
  has_many :answers, through: :user_answers

  # Validations
  validates :body, presence: true
  validates :body, url: true, if: -> { question_type != "text" }
  validates :question_type, presence: true

  def corrects
    user_answers.where(correct: true)
  end

  def falses
    user_answers.where(correct: false)
  end
end
