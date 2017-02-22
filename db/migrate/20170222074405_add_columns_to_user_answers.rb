class AddColumnsToUserAnswers < ActiveRecord::Migration
  def change
    add_column :user_answers, :start_time, :datetime
    add_column :user_answers, :end_time, :datetime
  end
end
