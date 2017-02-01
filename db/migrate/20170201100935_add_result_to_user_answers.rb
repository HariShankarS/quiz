class AddResultToUserAnswers < ActiveRecord::Migration
  def change
    add_column :user_answers, :result, :boolean
  end
end
