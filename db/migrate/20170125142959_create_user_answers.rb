class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :question_id
      t.integer :answer_id
      t.integer :attempt_id

      t.timestamps null: false
    end
  end
end
