class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
    end

    create_table   :categories_games do |t|
      t.belongs_to :category, index: true
      t.belongs_to :game, index: true
      t.integer    :corrects, default: 0
    end

    remove_column :games, :categories, :string
  end
end
