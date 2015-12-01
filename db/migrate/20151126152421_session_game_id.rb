class SessionGameId < ActiveRecord::Migration
  def change
    add_column :sessions, :game_id, :integer, null: false
    add_column :sessions, :expiration, :datetime, null: false
  end
end
