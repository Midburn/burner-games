class QuestionCategoryId < ActiveRecord::Migration[4.2]
  def change
    rename_column :questions, :category, :category_id
  end
end
