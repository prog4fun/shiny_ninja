# encoding: UTF-8

class ReportsController < ApplicationController
  # Filter
  before_filter :authenticate_user!
  before_filter :add_breadcrumb_index
  load_and_authorize_resource
  
  # Includes
  include ApplicationHelper
  
  def index
    
    if params[:projects_user].present?
      @active_menu = "evaluate_project"
      @evaluate_page = true
      @projects_user = ProjectsUser.find(params[:projects_user])
      
    else # see _search_bar !
      @active_menu = "report"
      @customers = Customer.where( :user_id => current_user.id)
      @projects = Project.where( :customer_id => @customers)
    end
    
    params[:search] ||= {}
    
    @date = Date.today  
    @reports_all = Report.search(params[:search], @projects_user, current_user)
    @reports = @reports_all.page(params[:page])
    @search_bar = true
    @reports_today = Report.showstats(@date.to_date..@date.to_date, @projects_user, current_user)
    @reports_this_month = Report.showstats(@date.beginning_of_month.to_date..@date.end_of_month.to_date, @projects_user, current_user)
    @reports_last_month = Report.showstats((@date - 1.month).beginning_of_month.to_date..(@date - 1.month).end_of_month.to_date, @projects_user, current_user)

    respond_to do |format|
      format.html
      format.csv  {
        params[:data] ||= {}
        projects_user = ProjectsUser.find(params[:projects_user]) if params[:projects_user].present?
        reports_for_download = Report.search(params[:data], projects_user, current_user)
        filename = reports_for_download.first.date.strftime("%d.%m.%Y-")
        filename << reports_for_download.last.date.strftime("%d.%m.%Y_")
        filename << t("activerecord.models.reports")
        filename << ".csv"
        
        send_data reports_for_download.download_csv, :filename => filename   }
    end
  end

  def show
    @report = Report.find(params[:id])
    
    my_services = Service.where("user_id = ?", current_user.id)
    my_reports = Report.where( :service_id => my_services)
    pes_projects = current_user.projects
    pes_reports = Report.where( :project_id => pes_projects)
     
    
    if my_reports.include?(@report)
      add_breadcrumb t("labels.actions.show"), report_path(@report)
      @active_menu = "report"

      respond_to do |format|
        format.html
      end
    elsif pes_reports.include?(@report)
      @active_menu = "evaluate_project"
      @evaluate_page = true

      respond_to do |format|
        format.html
      end
    else
      not_own_object_redirection
    end
  end

  def new
    if params[:report].present?
      @report = Report.new :date => params[:report][:date],
        :project_id => params[:report][:project_id]
    else
      @report = Report.new :date => Date.today
    end
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
      if @report.save
        if !@report.wage.presence
          @report.update_attributes(:wage => @report.service.wage)
        end
        if params[:saveandnew]
          format.html { redirect_to :controller => "reports", :action => "new", :report => params[:report], notice: t("confirmations.messages.saved_and_new") }
        else
          format.html { redirect_to @report, notice: t("confirmations.messages.saved") }
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @report = Report.find(params[:id])
    customers = Customer.where( :user_id => current_user.id)
    @projects = Project.where( :customer_id => customers)
    @services = Service.where( :user_id => current_user.id)
    service_before_update = @report.service
    
    @active_menu = "report"

    respond_to do |format|
      if @report.update_attributes(params[:report])
        check_and_update_wages(service_before_update)
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
  
  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), reports_path, :title => t("labels.breadcrumbs.index_title")
  end
  
  # Wages will only be updated if the Service has been changed
  # It might be possible, that the wages change of a Service,
  # after that the User updates e.g. the Date of a Report,
  # in this case the wages must not be updated.
  def check_and_update_wages(service_before_update)
    unless @report.service == service_before_update
      @report.update_attributes(:wage => @report.service.wage)
    end
     if !@report.wage.presence
      @report.update_attributes(:wage => @report.service.wage)
     end
  end
  
end
