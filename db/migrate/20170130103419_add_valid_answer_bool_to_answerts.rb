class AddValidAnswerBoolToAnswerts < ActiveRecord::Migration
  def change
  	add_column :options, :valid_answer, :boolean
  	rename_column :options, :option, :value
  end
end
