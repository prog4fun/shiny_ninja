# encoding: UTF-8

class ReportsController < ApplicationController
  # Filter
  before_filter :authenticate_user!
  before_filter :add_breadcrumb_index
  load_and_authorize_resource
  
  def index
    
    if current_user.is? :project_evaluator
      @projects = current_user.projects
      customer_ids = Array.new
      @projects.each{|project| customer_ids.push(project.customer_id)}
      @customers = Customer.where(:id => customer_ids)
    else
      @customers = Customer.where( :user_id => current_user.id)
      @projects = Project.where( :customer_id => @customers)
    end
    
    
    params[:search] ||= {}
    @reports = Report.search(params[:search], current_user).page(params[:page])
    
    @active_menu = "report"
    @search_bar = true

    respond_to do |format|
      format.html
    end
  end

  def show
    @report = Report.find(params[:id])
    
    my_services = Service.where("user_id = ?", current_user.id)
    my_reports = Report.where( :service_id => my_services)
    pes_projects = current_user.projects
    pes_reports = Report.where( :project_id => pes_projects)
     
    
    if my_reports.include?(@report)
      @active_menu = "report"
      add_breadcrumb t("labels.actions.show"), report_path(@report)

      respond_to do |format|
        format.html
      end
    elsif pes_reports.include?(@report)
      @active_menu = "report"
      add_breadcrumb t("labels.actions.show"), report_path(@report)

      respond_to do |format|
        format.html
      end
    else
      not_own_object_redirection
    end
  end

  def new
    @report = Report.new
    customers = Customer.where( :user_id => current_user.id)
    @projects = Project.where( :customer_id => customers)
    @services = Service.where( :user_id => current_user.id)
    
    @active_menu = "report"
    add_breadcrumb t("labels.actions.new"), new_report_path

    respond_to do |format|
      format.html
    end
  end

  def edit
    @report = Report.find(params[:id])

    customers = Customer.where( :user_id => current_user.id)
    @projects = Project.where( :customer_id => customers)
    @services = Service.where("user_id = ?", current_user.id)
    my_reports = Report.where( :service_id => @services)
    
    if my_reports.include?(@report)
      @active_menu = "report"
      add_breadcrumb t("labels.actions.edit"), edit_report_path(@report.id)
    else
      not_own_object_redirection
    end
  end

  def create
    @report = Report.new(params[:report])
    customers = Customer.where( :user_id => current_user.id)
    @projects = Project.where( :customer_id => customers)
    @services = Service.where( :user_id => current_user.id)
    
    @active_menu = "report"

    respond_to do |format|
      params[:report][:country] = "de"
      if @report.save
        format.html { redirect_to @report, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @report = Report.find(params[:id])
    customers = Customer.where( :user_id => current_user.id)
    @projects = Project.where( :customer_id => customers)
    @services = Service.where( :user_id => current_user.id)
    
    @active_menu = "report"

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @report = Report.find(params[:id])
    
    @active_menu = "report"
    
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url }
    end
  end
  
  #######################################################################
  
  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), reports_path, :title => t("labels.breadcrumbs.index_title")
  end
end
