class RemoveAnsweredCorrectly < ActiveRecord::Migration[4.2]
  def change
    remove_column :games, :answered_correctly, :string
  end
end
