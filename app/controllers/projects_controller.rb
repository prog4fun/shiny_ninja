# encoding: UTF-8

class ProjectsController < ApplicationController

  # Filter
  before_filter :authenticate_user!
  before_filter :add_breadcrumb_index
  load_and_authorize_resource
  
  def index
    @customers = Customer.where( :user_id => current_user.id )
    params[:search] ||= {}
    @projects = Project.search(params[:search], current_user).page(params[:page])
    
    @active_menu = "project"
    @search_bar = true
    @head1 = t("activerecord.models.projects")

    respond_to do |format|
      format.html
    end
  end

  def show
    @project = Project.find(params[:id])
    
    customers = current_user.customers
    my_projects = Project.where( :customer_id => customers)
    
    if my_projects.include?(@project)
      @active_menu = "project"
      @head1 = "#{t("labels.actions.show")} <#{@project.name}"
      add_breadcrumb t("labels.actions.show"), project_path(@project)

      respond_to do |format|
        format.html
      end
    else
      not_own_object_redirection
    end
  end

  def new
    @project = Project.new
    @customers = Customer.where( :user_id => current_user.id )
    
    @active_menu = "project"
    @head1 = "#{t("labels.actions.new")} #{t("activerecord.models.projects")}"
    add_breadcrumb t("labels.actions.new"), new_project_path

    respond_to do |format|
      format.html
    end
  end

  def edit
    @project = Project.find(params[:id])

    @customers = current_user.customers
    my_projects = Project.where( :customer_id => @customers)
    
    if my_projects.include?(@project)    
      @active_menu = "project"
      @head1 = "#{t("labels.actions.edit")} #{t("activerecord.models.project")}"
      add_breadcrumb t("labels.actions.edit"), edit_project_path(@project.id)
    else
      not_own_object_redirection
    end
  end

  def create
    @project = Project.new(params[:project])
    
    @active_menu = "project"

    respond_to do |format|
      params[:project][:country] = "de"
      if @project.save
        format.html { redirect_to @project, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @project = Project.find(params[:id])
    
    @active_menu = "project"

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    
    @active_menu = "project"
    
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
    end
  end
  
  #######################################################################
  
  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), projects_path, :title => t("labels.breadcrumbs.index_title")
  end
end
