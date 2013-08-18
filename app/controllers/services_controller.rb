# encoding: UTF-8

class ServicesController < ApplicationController
  # Filter
  before_filter :authenticate_user!
  # before_filter :add_breadcrumb_index
  load_and_authorize_resource
  
  def index
    params[:search] ||= {}
    @services = Service.search(params[:search], current_user).page(params[:page])
    
    @active_menu = "service"
    @search_bar = true

    respond_to do |format|
      format.html
    end
  end

  def show
    @service = Service.find(params[:id])
    
    if @service.user_id == current_user.id
      @active_menu = "service"
      add_breadcrumb t("labels.actions.show"), service_path(@service)

      respond_to do |format|
        format.html
      end
    else
      not_own_object_redirection
    end
  end

  def new
    @service = Service.new
    
    my_services = Service.where("user_id = ?", current_user.id)
    
    if my_services.include?(@service)
      @active_menu = "service"
      add_breadcrumb t("labels.actions.new"), new_service_path

      respond_to do |format|
        format.html
      end
    end
  end

  def edit
    @service = Service.find(params[:id])
    
    my_services = Service.where("user_id = ?", current_user.id)
    
    if my_services.include?(@service)
      @active_menu = "service"
      add_breadcrumb t("labels.actions.edit"), edit_service_path(@service.id)
    else
      not_own_object_redirection
    end
  end

  def create
    @service = Service.new(params[:service])
    
    @active_menu = "service"

    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @service = Service.find(params[:id])
    
    @active_menu = "service"

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to @service, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @service = Service.find(params[:id])
    
    @active_menu = "service"
    
    @service.destroy

    respond_to do |format|
      format.html { redirect_to services_url }
    end
  end
  
  #######################################################################
  
  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), services_path, :title => t("labels.breadcrumbs.index_title")
  end
end
