# encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_post_params
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: t("labels.authorization.denied")
  end

  def set_post_params
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # Index Broadcrumpb
  add_breadcrumb @breadcrump_index_name, :root_path

  def not_own_object_redirection
    raise ActiveRecord::RecordNotFound
  end

  # Parameters for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:firstname, :lastname, :email, :roles_mask]
  end

end
