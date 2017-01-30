ActiveAdmin.register Evaluation do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :time_per_question, :time_independent, :question_time_setting

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
    column :question do |evaluation|
      link_to "Add Question",new_admin_question_path(:question => {evaluation_id: evaluation.id})
    end
    actions
  end
  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name, :input_html => { :style => 'width:15%'}
      f.input :time_per_question, :input_html => { :style => 'width:5%'}
      f.input :time_independent
      f.input :question_time_setting
    end
    f.actions
  end
end
