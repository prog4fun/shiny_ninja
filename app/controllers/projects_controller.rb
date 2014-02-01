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

    respond_to do |format|
      format.html
    end
  end

  def show
    @project = Project.find(params[:id])
    
    customers = current_user.customers
    my_projects = Project.where( :customer_id => customers)
    
    if my_projects.include?(@project)
      @projects_users = ProjectsUser.where( :project_id => @project.id )
      @active_menu = "project"
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
    @evaluators = @project.users
    
    @active_menu = "project"
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
      @projects_users = ProjectsUser.where( :project_id => @project.id )
      @active_menu = "project"
      add_breadcrumb t("labels.actions.edit"), edit_project_path(@project.id)
    else
      not_own_object_redirection
    end
  end

  def create
    @project = Project.new(project_params)
    @customers = Customer.where( :user_id => current_user.id )
    
    @active_menu = "project"

    respond_to do |format|

      if @project.save
        format.html { redirect_to @project, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @project = Project.find(params[:id])
    @customers = Customer.where( :user_id => current_user.id )
    @projects_users = ProjectsUser.where( :project_id => @project.id )
    
    @active_menu = "project"

    respond_to do |format|
      if @project.update_attributes(project_params)
        format.html { redirect_to @project, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    
    @active_menu = "project"
    
    dependency = @project.reports.count
    dependency += @project.users.count
    if dependency > 0
      flash[:alert] = t("activerecord.models.project") + t("errors.messages.dependency_exists") + " (#{t("activerecord.models.reports")}/#{t("labels.roles.projectevaluator")})."
      redirect_to projects_url
    else
      @project.destroy

      respond_to do |format|
        format.html { redirect_to projects_url }
      end
    end
  end
  
  #######################################################################
  
  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), projects_path, :title => t("labels.breadcrumbs.index_title")
  end
  
  def project_params
	params.require(:project).permit(:comment, :customer_id, :name, :timebudget)
  end
end
