class GamesCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :games, :categories, :string, null: false
  end
end
