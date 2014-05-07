# encoding: UTF-8

class ReportsController < ApplicationController
  # Filter
  before_filter :authenticate_user!
  before_filter :add_breadcrumb_index
  before_action :get_my_reports, only: [:show, :archive, :restore]
  load_and_authorize_resource

  # Includes
  include ApplicationHelper

  def index

    if params[:projects_user].present? # index for project_evaluator
      @active_menu = "evaluate_project"
      @evaluate_page = true
      @projects_user = ProjectsUser.find(params[:projects_user])
      params[:search] ||= {date_from: (Date.today - 3.months).beginning_of_month}

    else # index for timetracker + _search_bar !
      @active_menu = "report"
      @customers = Customer.where(:user_id => current_user.id)
      @projects = Project.where(:customer_id => @customers)
      params[:search] ||= {date_from: (Date.today - 3.months).beginning_of_month, archived: 'false'}
    end

    @date = Date.today
    @reports_all = Report.search(params[:search], @projects_user, current_user)
    @reports = @reports_all.page(params[:page])
    @search_bar = true
    @reports_today = Report.showstats(@date.to_date..@date.to_date, @projects_user, current_user)
    @reports_this_month = Report.showstats(@date.beginning_of_month.to_date..@date.end_of_month.to_date, @projects_user, current_user)
    @reports_last_month = Report.showstats((@date - 1.month).beginning_of_month.to_date..(@date - 1.month).end_of_month.to_date, @projects_user, current_user)

    respond_to do |format|
      format.html
      format.csv {
        params[:data] ||= {}
        projects_user = ProjectsUser.find(params[:projects_user]) if params[:projects_user].present?
        reports_for_download = Report.search(params[:data], projects_user, current_user)
        filename = reports_for_download.first.date.strftime("%d.%m.%Y-")
        filename << reports_for_download.last.date.strftime("%d.%m.%Y_")
        filename << t("activerecord.models.reports")
        filename << ".csv"

        send_data reports_for_download.download_csv, :filename => filename }
    end
  end

  def show
    @evaluate_page = true if params[:projects_user].present?
    @report = Report.find(params[:id])

    pes_projects = current_user.projects
    pes_reports = Report.where(:project_id => pes_projects)


    if @my_reports.include?(@report)
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
    customers = Customer.where(:user_id => current_user.id)
    @projects = Project.where(customer_id: customers, archived: false)
    @services = Service.where(:user_id => current_user.id)

    @active_menu = "report"
    add_breadcrumb t("labels.actions.new"), new_report_path

    respond_to do |format|
      format.html
    end
  end

  def edit
    @report = Report.find(params[:id])

    customers = Customer.where(:user_id => current_user.id)
    @projects = Project.where(customer_id: customers, archived: false)
    @services = Service.where("user_id = ?", current_user.id)
    my_reports = Report.where(:service_id => @services)

    if my_reports.include?(@report)
      @active_menu = "report"
      add_breadcrumb t("labels.actions.edit"), edit_report_path(@report.id)
    else
      not_own_object_redirection
    end
  end

  def create
    @report = Report.new(report_params)
    customers = Customer.where(:user_id => current_user.id)
    @projects = Project.where(customer_id: customers, archived: false)
    @services = Service.where(:user_id => current_user.id)

    @active_menu = "report"

    respond_to do |format|
      if @report.save
        if @report.wage.blank?
          @report.update_attributes(:wage => get_wage)
        end
        if params[:saveandnew]
          format.html { redirect_to :controller => "reports", :action => "new", :report => report_params, notice: t("confirmations.messages.saved_and_new") }
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
    customers = Customer.where(:user_id => current_user.id)
    @projects = Project.where(customer_id: customers, archived: false)
    @services = Service.where(:user_id => current_user.id)

    @active_menu = "report"

    respond_to do |format|
      if @report.update_attributes(report_params)
        check_and_update_wages
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

  def archive
    report = Report.find(params[:id])
    if @my_reports.include?(report)
      if report.archived?
        redirect_to report, alert: t("labels.state.archived_already_info", element: t("activerecord.models.report"))
      else
        report.update_attributes(archived: true)
        redirect_to report, notice: t("labels.actions.archive_notice", element: t("activerecord.models.report"))
      end
    else
      not_own_object_redirection
    end
  end

  def restore
    report = Report.find(params[:id])
    if @my_reports.include?(report)
      if report.archived?
        report.update_attributes(archived: false)
        redirect_to report, notice: t("labels.actions.restore_notice", element: t("activerecord.models.report"))
      else
        redirect_to report, alert: t("labels.state.not_archived_already_info", element: t("activerecord.models.report"))
      end
    else
      not_own_object_redirection
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
  def check_and_update_wages
    @report.update_attributes(:wage => get_wage) if @report.wage.blank?
  end

  def report_params
    params.require(:report).permit(:comment, :date, :duration, :project_id, :service_id, :wage)
  end

  def get_my_reports
    my_services = Service.where("user_id = ?", current_user.id)
    @my_reports = Report.where(:service_id => my_services)
  end

  def get_wage
    wage = @report.project.wage
    return wage if wage.present?
    return @report.service.wage
  end

end
