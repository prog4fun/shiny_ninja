class RegistrationsController < Devise::RegistrationsController
  
  def after_inactive_sign_up_path_for(resource)
    url_for(new_session_path(resource_name))
  end
  
end