class AddAnswerToOptions < ActiveRecord::Migration
  def change
    add_column :options, :answer, :boolean
  end
end
