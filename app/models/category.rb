class Category < ActiveRecord::Base
  has_many :questions
  has_many :games, through: :categories_game
  has_many :categories_games

  def self.random
    Category.all.to_a.sample
  end
end