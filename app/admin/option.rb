ActiveAdmin.register Option do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :option, :question_id
#
# or
#
controller do
  def create
    create! do |format|
      format.html { redirect_to admin_questions_path }
    end
  end
end
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
form do |f|
  f.semantic_errors # shows errors on :base
  f.inputs  do        # builds an input field for every attribute
    f.input :option
    f.input :question_id, :as => :select, :collection => Question.all.map{|u| ["#{u.question}", u.id]}
  end
  f.actions  
end

end
