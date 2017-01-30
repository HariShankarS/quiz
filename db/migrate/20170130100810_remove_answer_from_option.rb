class RemoveAnswerFromOption < ActiveRecord::Migration
  def change
  	remove_column :options, :answer
  end
end
