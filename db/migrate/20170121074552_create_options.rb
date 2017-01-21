class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :option
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
