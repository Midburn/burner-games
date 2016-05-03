class Question < ActiveRecord::Base

  # enums
  enum question_type: [ :text, :image, :video ]
  enum category:  [ :other, :inclusion, :gifting, :decommodification, :radical_self_reliance,
                    :radical_self_expression, :communal_effort, :civic_responsibility,
                    :leaving_no_trace, :participation, :immediacy ]
  enum level: { easy: 0, very_hard: 100 }

  # associations
  has_many :user_answers, dependent: :destroy
  has_many :answers, through: :user_answers, dependent: :destroy
  has_and_belongs_to_many :games, through: :games_questions

  # validations
  validates :body, presence: true
  validates :body, url: true, if: -> { question_type != "text" }
  validates :question_type, presence: true

  # scopes
  scope :easy,      -> { where level: 0 }
  scope :very_hard, -> { where level: 100 }

  # nested attributes
  accepts_nested_attributes_for :answers

  def self.random_question(category)
    question = Question.where(category: Question.categories[category]).sample
    raise "Could not retrieve a random question. Questions db might be empty!" if question.nil?
    
    question
  end

  def self.random_categories(count)
    random_categories = []
    loop do
      category = Question.categories.keys.sample
      random_categories << category unless random_categories.include? category
      break if random_categories.count >= count
    end
    random_categories
  end

  def corrects
    user_answers.where(correct: true).collect { |a| a.answer }
  end

  def falses
    user_answers.where(correct: false).collect { |a| a.answer }
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
