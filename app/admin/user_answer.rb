ActiveAdmin.register UserAnswer do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

show do |ad|
  attributes_table do
  	row :id
    row :question
    row :correct
    row :answer_id
    row :attempt
    row :user do |ua|
      ua.attempt.user.email
    end
    row :start_time
    row :end_time
    row :time_taken do |t|
      t.time_taken.to_s + " sec"
    end
  end
end

index do
  id_column
  column :question
  column :correct
  column :answer_id
  column :attempt
  column :user do |ua|
    ua.attempt.user.email
  end
  column :time_taken do |t|
    t.time_taken.to_s + " sec"
  end
  actions
end
end
