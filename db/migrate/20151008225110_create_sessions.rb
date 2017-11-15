class CreateSessions < ActiveRecord::Migration[4.2]
  def change
    create_table :sessions do |t|
      t.string :token

      t.timestamps
    end
  end
end
