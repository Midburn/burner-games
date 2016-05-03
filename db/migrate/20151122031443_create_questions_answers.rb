class CreateQuestionsAnswers < ActiveRecord::Migration
  def change

    create_table :questions do |t|
      t.string   :body, null: false
      t.integer  :question_type, null: false, default: 0
      t.integer  :level, default: 0
      t.integer  :category, default: 0

      t.timestamps
    end

    create_table :answers do |t|
      t.integer  :answer_type, null: false, default: 0
      t.string   :body, null: false

      t.timestamps
    end

    create_table   :user_answers do |t|
      t.belongs_to :question, index: true
      t.belongs_to :answer, index: true
      t.boolean    :correct, null: false, default: false
    end
  end
end
