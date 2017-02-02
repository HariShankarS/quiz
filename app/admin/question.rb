ActiveAdmin.register Question do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :question, :evaluation_id, :time, :start_time, :end_time, options_attributes: [:id, :value, :valid_answer, :_destroy => true]
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
after_save :notify_multiple_answers

controller do
  def update
    update! do |format|
      format.html { redirect_to admin_questions_path }
    end
  end
  def create
    create! do |format|
      format.html { redirect_to admin_questions_path }
    end
  end


  def notify_multiple_answers(obj)
    t = params.require(:question).require(:options_attributes).permit!
    t_size = t.select { |k,v| v["valid_answer"] == "1" }.size
    if t_size > 1
      flash[:warning] = "You saved #{t_size} valid answers for question ##{obj.try(:id)}"
    end
  end
end

show do |ad|
   attributes_table do
     row :question
     row :correct_answers do |q|
       q.correct_answers.collect(&:value).join(", ")
     end
     row :time
     row :evaluation_id
     row :created_at
     row :updated_at
   end
end



form do |f|
  f.semantic_errors *f.object.errors.keys
  f.inputs do
    f.input :evaluation_id, :as => :select, :collection => Evaluation.all.map{|t| ["#{t.name}", t.id]}
    f.input :question, :input_html => { :rows => 1, :style => 'width:50%'}
    f.input :time, :input_html => { :style => 'width:3%', :value => f.object.persisted? ? f.object.time : Question.set_time(params[:question].try(:[], :evaluation_id)), :disabled => Question.disable_time(params[:question].try(:[], :evaluation_id))}
    f.has_many :options, heading: 'Options', allow_destroy: true, new_record: 'Add option' do |a|
      a.input :value, :input_html => { :style => 'width:10%'}
      a.input :valid_answer, as: :boolean
    end
  end
  f.actions
end

index do
  id_column
  column :question
  column :correct_answers do |q|
    q.correct_answers.collect(&:value).join(", ")
  end
  column :evaluation_id
  column :options do |question|
    question.options.collect(&:value).join(", ")
  end
  column :option do |question|
    link_to "Add Option",new_admin_option_path(:option => {question_id: question.id})
  end
  actions
end

end
