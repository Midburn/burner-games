class AddGamesCorrectCounter < ActiveRecord::Migration
  def change
    add_column :games, :answered_correctly, :integer, null: false, default: 0
  end
end
