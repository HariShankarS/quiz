ActiveAdmin.register Referral do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :code, :expiry_date
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  form do |f|
    f.inputs do
      f.input :code, :input_html => { :style => 'width:10%'}
      f.input :expiry_date, :as => :datepicker, :input_html => { :style => 'width:10%'}
    end
    f.actions
  end

end
