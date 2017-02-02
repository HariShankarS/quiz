ActiveAdmin.register Attempt do

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
    row :user
    row :evaluation
    row :unfinished
    row :created_at
    row :updated_at
  end
end

index do
  id_column
  column :user
  column :evaluation
  column :unfinished
  actions
end

end
