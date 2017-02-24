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
    row :score
    row :created_at
    row :updated_at
  end
  panel "UserAnswers" do
    table_for attempt.user_answers do
      column :id
      column :question do |q|
        q.question.question
      end
      column :correct
      column :answer_id
      column :time_taken do |t|
        t.time_taken.to_s + " sec"
      end
    end
  end
end

index do
  id_column
  column :user
  column :evaluation
  column :unfinished
  column :score
  actions
end

end
