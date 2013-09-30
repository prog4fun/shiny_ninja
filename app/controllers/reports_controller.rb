# encoding: UTF-8

class ReportsController < ApplicationController
  # Filter
  before_filter :authenticate_user!
  before_filter :add_breadcrumb_index
  load_and_authorize_resource
  
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
    @reports = Report.search(params[:search], @projects_user, current_user).page(params[:page])
    
    @search_bar = true 
    
    @reports_all = Report.search(params[:search], @projects_user, current_user)
    
    @statistics_duration_all = 0
   	@statistics_wages_all = 0
    @reports_all.each do |statistics|
    	@statistics_duration_all += statistics.duration
    	@statistics_wages_all += statistics.service.wage
    end
    
    @date = Date.today
	@this_month = @date.strftime("%B")
	
    params[:search_this_month] ||= {
	    :date_from => @date.beginning_of_month,
	    :date_to => @date.end_of_month
    }
    @reports_this_month = Report.search(params[:search_this_month], @projects_user, current_user)
    
    @statistics_duration_this_month = 0
    @statistics_wages_this_month = 0
    @reports_this_month.each do |statistics|
    	@statistics_duration_this_month += statistics.duration
    	@statistics_wages_this_month += statistics.service.wage
    end
    
    @last_month = @date - 1.month
    
    params[:search_last_month] ||= {
	    :date_from => @last_month.beginning_of_month,
	    :date_to => @last_month.end_of_month
    }
    @reports_last_month = Report.search(params[:search_last_month], @projects_user, current_user)
    
    @statistics_duration_last_month = 0
    @statistics_wages_last_month = 0
    @reports_last_month.each do |statistics|
    	@statistics_duration_last_month += statistics.duration
    	@statistics_wages_last_month += statistics.service.wage
    end
    
    @last_month = @last_month.strftime("%B")

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
        :project_id => params[:report][:project_id],
        :service_id => params[:report][:service_id]
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
  
  def import
    
  end
  
  
  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), reports_path, :title => t("labels.breadcrumbs.index_title")
  end
end
