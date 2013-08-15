# encoding: UTF-8

class IndicesController < ApplicationController
  
  before_filter :add_breadcrumb_index
  
  
  def index
    if current_user.nil?
      redirect_to(:controller => "indices", :action => "home") and return
    else
      if current_user.is? :time_tracker
        redirect_to(:controller => "reports", :action => "index") and return
      elsif current_user.is? :project_evaluator
        redirect_to(:controller => "reports", :action => "index") and return
      elsif current_user.is? :administrator
        redirect_to(:controller => "users", :action => "adm_index") and return
      end
    end

  end
  
  def home
    # for users, which are not logged in
    @head1 = "Willkommen"
  end

  def administrator
    @active_menu = "home"
    @head1 = "Willkommen"
    add_breadcrumb t("labels.roles.administrator")
  end
  
  def timetracker
    @active_menu = "home"
    @head1 = "Willkommen"
    add_breadcrumb t("labels.roles.timetracker")
    
  end
  
  def projectevaluator
    @active_menu = "home"
    @head1 = "Willkommen"
    add_breadcrumb t("labels.roles.projectevaluator")
  end

  #######################################################################
  
  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), services_path, :title => t("labels.breadcrumbs.index_title")
  end
  
  
end
