class AddGamesCorrectCounter < ActiveRecord::Migration[4.2]
  def change
    add_column :games, :answered_correctly, :integer, null: false, default: 0
  end
end
