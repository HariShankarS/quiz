class RemoveColumnsFromQuestions < ActiveRecord::Migration
  def change
  	remove_column :questions, :start_time, :datetime
  	remove_column :questions, :end_time, :datetime
  end
end
