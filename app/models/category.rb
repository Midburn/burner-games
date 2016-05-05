class Category < ActiveRecord::Base
  has_many :questions
  has_many :games, through: :categories_game
  has_many :categories_games

  def self.initialize_categories
    Category.find_or_create_by(name: "other")
    Category.find_or_create_by(name: "inclusion")
    Category.find_or_create_by(name: "gifting")
    Category.find_or_create_by(name: "decommodification")
    Category.find_or_create_by(name: "radical_self_reliance")
    Category.find_or_create_by(name: "radical_self_expression")
    Category.find_or_create_by(name: "communal_effort")
    Category.find_or_create_by(name: "civic_responsibility")
    Category.find_or_create_by(name: "leaving_no_trace")
    Category.find_or_create_by(name: "participation")
    Category.find_or_create_by(name: "immediacy")    
  end

  def self.random
    Category.all.to_a.sample
  end
end