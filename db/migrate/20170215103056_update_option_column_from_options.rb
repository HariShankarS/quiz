class UpdateOptionColumnFromOptions < ActiveRecord::Migration
  def change
  	change_column :options, :value, :text
  end
end
