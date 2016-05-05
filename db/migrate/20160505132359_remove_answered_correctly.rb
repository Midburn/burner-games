class RemoveAnsweredCorrectly < ActiveRecord::Migration
  def change
    remove_column :games, :answered_correctly, :string
  end
end
