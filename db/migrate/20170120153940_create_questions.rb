class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :answer
      t.integer :test_id
      t.integer :time
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
