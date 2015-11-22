class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :token

      t.timestamps
    end
  end
end
