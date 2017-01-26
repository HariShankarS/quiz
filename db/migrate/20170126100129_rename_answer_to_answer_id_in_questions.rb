class RenameAnswerToAnswerIdInQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :answer, :answer_id
  end
end
