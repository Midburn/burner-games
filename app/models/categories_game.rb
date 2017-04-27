class CategoriesGame < ActiveRecord::Base
  belongs_to :game
  belongs_to :category
  
  CATEGORY_COMPLETED = 2

  def completed?
    corrects >= CATEGORY_COMPLETED
  end

  def name
    category.name
  end

  def answered_correctly
    update_column(:corrects, corrects+1)
  end

  def questions
    game.questions.where(category: category)
  end
end