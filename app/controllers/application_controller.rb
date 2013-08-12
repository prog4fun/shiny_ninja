# encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => t("labels.authorization.denied")
  end
  
  # Index Broadcrumpb
  add_breadcrumb @breadcrump_index_name, :root_path
  
  def not_own_object_redirection
    raise ActiveRecord::RecordNotFound
  end
  
end
