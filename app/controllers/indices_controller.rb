# encoding: UTF-8

class IndicesController < ApplicationController

  before_filter :add_breadcrumb_index
  before_filter :check_browser


  def start
    if current_user.nil?
      redirect_to(:controller => "indices", :action => "home") and return
    else
      if current_user.is? :administrator
        redirect_to(:controller => "users", :action => "index") and return
      else
        redirect_to(:controller => "reports", :action => "index") and return
      end
    end

  end

  def home
  end

  def impressum
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

  def check_browser
    if browser.ie?
      flash[:alert] = "Achtung! Sie benutzen den Internet-Explorer. Einige Features werden daher nicht unterstüzt. Bitte wechseln Sie den Browser für maximale Funktionalität."
    elsif !browser.modern?
      flash[:alert] = "Achtung! Sie benutzen #{browser.name} #{browser.version}. Bitte wechseln Sie zu einer neueren Version ihres Browser für maximale Funktionalität."
    end
  end


end
