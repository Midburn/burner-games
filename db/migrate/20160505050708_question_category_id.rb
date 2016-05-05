class QuestionCategoryId < ActiveRecord::Migration
  def change
    rename_column :questions, :category, :category_id
  end
end
