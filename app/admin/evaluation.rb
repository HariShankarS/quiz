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
    column :time_per_question
    column :time_independent
    column :question_time_setting
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

  show do
    attributes_table do
      row :id
      row :name
      row :time_per_question
      row :time_independent
      row :question_time_setting
      row :created_at
      row :updated_at
      row :question do
        link_to "Add Question",new_admin_question_path(:question => {evaluation_id: evaluation.id})
      end
    end
    panel "Questions" do
      table_for evaluation.questions do
        column :id
        column :number
        column :question
        column :correct_answers do |q|
          q.correct_answers.collect(&:value).join(", ")
        end
        column :view do |question|
          link_to "View",admin_question_path(question.id)
        end
        column :edit do |question|
          link_to "Edit",edit_admin_question_path(question.id, :method => "PATCH")
        end
        column :delete do |question|
          link_to("Delete", "/admin/questions/#{question.id}", :method => :delete, :data => {:confirm => "Are you sure?"})
        end
      end
    end
  end


end
