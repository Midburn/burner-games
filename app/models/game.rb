class Game < ApplicationRecord

  include Tokenable
  tokenable_by 6

  CATEGORIES_IN_GAME    = ENV["CATEGORIES_IN_GAME"].present? ? ENV["CATEGORIES_IN_GAME"].to_i : 5
  QUESTIONS_IN_CATEGORY = ENV["QUESTIONS_IN_CATEGORY"].present? ? ENV["QUESTIONS_IN_CATEGORY"].to_i : 6

  # Associations
  has_many :categories_game
  has_many :categories, through: :categories_game
  has_and_belongs_to_many :questions, through: :games_questions

  # Validations
  validates :user_id, presence: true # ever game must belong to a user

  def self.create_new_game(user_id)
    game = Game.new user_id: user_id

    # set categories
    game.categories << Category.first(Game::CATEGORIES_IN_GAME)

    # load questions into the game
    game.categories.each do |category|
      Game::QUESTIONS_IN_CATEGORY.times do
        game.add_question(category)
      end
    end

    game.save!
    game
  end

  def add_question(category)
    # choose the next question for the user
    # if question is new in game or if there are no other questions in specified category
    question = loop do 
      qq = Question.where(category: category).sample
      raise "Could not find any question with category: #{category.name}" if qq.nil?
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

  def drupal_login
    url = "#{ENV["DRUPAL_API_BASE"]}/user/login"
    options = {
      headers: {
         "cache-control": "no-cache",
         "content-type": "application/x-www-form-urlencoded",
      },
      body: {
        username: ENV["DRUPAL_ADMIN_USERNAME"],
        password: ENV["DRUPAL_ADMIN_PASSWORD"],
      }
    }

    # preform the request
    response = HTTParty.post(url, options)

    response["sessid"]
  end

  def drupal_mark_completed!
    # ugly patch to support games api for v1 release
    session_id = drupal_login

    url = "#{ENV["DRUPAL_API_BASE"]}/games/#{user_id}/pass"
    options =  { 
      "cache-control": "no-cache",
      "content-type": "application/x-www-form-urlencoded",
      "x-csrf-token": session_id, 
    }

    response = HTTParty.post(url, options)

    response.include? true
  end
end