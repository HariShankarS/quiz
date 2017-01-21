ActiveAdmin.register Test do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
index do
  id_column
  column :name
  column :question do |test|
    link_to "Add Question",new_admin_question_path(:question => {test_id: test.id})
  end
  actions
end

end
