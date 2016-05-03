class GamesCategories < ActiveRecord::Migration
  def change
    add_column :games, :categories, :string, null: false
  end
end
