class RenameColumnResultInUserAnswers < ActiveRecord::Migration
  def change
    rename_column :user_answers, :result, :correct
  end
end
