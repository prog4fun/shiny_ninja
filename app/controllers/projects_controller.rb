# encoding: UTF-8

class ProjectsController < ApplicationController

  # Filter
  before_filter :authenticate_user!
  before_filter :add_breadcrumb_index
  before_action :get_my_projects, only: [:show, :archive, :restore]
  load_and_authorize_resource

  def index
    @customers = Customer.where(:user_id => current_user.id)
    params[:search] ||= {archived: 'false'}
    @projects = Project.search(params[:search], current_user).page(params[:page])

    @active_menu = "project"
    @search_bar = true

    respond_to do |format|
      format.html
    end
  end

  def show
    @project = Project.find(params[:id])

    # customers = current_user.customers
    # my_projects = Project.where(:customer_id => customers)

    if @my_projects.include?(@project)
      @projects_users = ProjectsUser.where(:project_id => @project.id)
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
    @customers = Customer.where(:user_id => current_user.id)
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
    my_projects = Project.where(:customer_id => @customers)

    if my_projects.include?(@project)
      @projects_users = ProjectsUser.where(:project_id => @project.id)
      @active_menu = "project"
      add_breadcrumb t("labels.actions.edit"), edit_project_path(@project.id)
    else
      not_own_object_redirection
    end
  end

  def create
    @project = Project.new(project_params)
    @customers = Customer.where(:user_id => current_user.id)

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
    @customers = Customer.where(:user_id => current_user.id)
    @projects_users = ProjectsUser.where(:project_id => @project.id)

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

  def archive
    project = Project.find(params[:id])
    if @my_projects.include?(project)
      if project.archived?
        redirect_to project, alert: t("labels.state.archived_already_info", element: t("activerecord.models.project"))
      else
        reports_of_project = Report.where(project_id: project.id)
        reports_of_project.each { |report| report.update_attributes(archived: true) }
        project.update_attributes(archived: true)
        redirect_to project, notice: t("activerecord.attributes.project.archive_notice")
      end
    else
      not_own_object_redirection
    end
  end

  def restore
    project = Project.find(params[:id])
    if @my_projects.include?(project)
      if project.archived?
        project.update_attributes(archived: false)
        redirect_to project, notice: t("labels.actions.restore_notice", element: t("activerecord.models.project"))
      else
        redirect_to project, alert: t("labels.state.not_archived_already_info", element: t("activerecord.models.project"))
      end
    else
      not_own_object_redirection
    end
  end

  #######################################################################

  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), projects_path, :title => t("labels.breadcrumbs.index_title")
  end

  def project_params
    params.require(:project).permit(:comment, :customer_id, :name, :timebudget, :wage)
  end

  def get_my_projects
    customers = current_user.customers
    @my_projects = Project.where(:customer_id => customers)
  end
end
