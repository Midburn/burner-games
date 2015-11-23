class CreateGamesQuestions < ActiveRecord::Migration
  def change
    create_table :games_questions, id: false do |t|
      t.references :game, index: true
      t.references :question, index: true
      t.timestamps
    end

    # validate that questions do not repeat on the same game
    add_index :games_questions, [:game_id, :question_id], :unique => true
  end
end
