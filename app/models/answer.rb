class Answer < ActiveRecord::Base

  enum answer_type: { text: 0, image: 1, video: 2 }

  # Associations
  belongs_to :question

  # Validations
  validates :answer_type, presence: true
  validates :body, presence: true
  validates :body, url: true, if: -> { answer_type != "text" }

end