# encoding: UTF-8

class Report < ActiveRecord::Base
  attr_accessible :comment, :date, :duration, :project_id, :service_id
  
  # associations
  belongs_to :project
  belongs_to :service
  
  # validations
  validates :comment, :date, :duration, :project_id, :service_id,
    :format => {:with => /^[^<>%&$]*$/}
  validates :date, :presence => true
  validates :duration, :presence => true
  validates :project_id, :presence => true
  validates :service_id, :presence => true
  
  # CSV-Download
  require 'csv'
  include ActionView::Helpers::NumberHelper
  def self.download_csv(options = {})
    headline = [I18n.t("activerecord.attributes.report.date"),
      I18n.t("activerecord.models.customer"),
      I18n.t("activerecord.models.project"),
      I18n.t("activerecord.models.service"),
      I18n.t("labels.roles.timetracker"),
      I18n.t("activerecord.attributes.report.duration"),
      I18n.t("labels.universe.comment")]
    CSV.generate(:col_sep => ";") do |csv|
      csv << headline
      all.each do |report|
        user = report.project.customer.user 
        user = user.firstname + " " + user.lastname
        ##
        data = [
          report.date,
          report.project.customer.name,
          report.project.name,
          report.service.name,
          user,
          report.duration.to_s.gsub(".",","),
          report.comment     ]
        # csv << report.attributes.values_at(*column_names)
        csv << data
      end
    end
  end
  
  
  # search
  def self.search(search, projects_user, current_user)
    
    if projects_user.present?
      result = Report.where( :project_id => projects_user.project.id)
      logger.debug "##########################################"
      logger.debug "1." + result.inspect
      logger.debug "##########################################"
    else
      services = Service.where("user_id = ?", current_user.id)
      result = Report.where( :service_id => services)
      logger.debug "##########################################"
      logger.debug "2." + result.inspect
      logger.debug "##########################################"
    end    
    
    if search
      if search["date_from"].present?
        result = result.where("date >= ?", search["date_from"].to_date)
      end
      if search["date_to"].present?
        result = result.where("date <= ?", search["date_to"].to_date)
      end
      if search["customer"].present?
        # you get the customer of a report only with the project
        project_customer = Project.where('customer_id = ?', search["customer"])
        result = result.where('project_id = ?', project_customer)
      end   
      if search["project"].present?
        result = result.where('project_id = ?', search["project"])
      end    
    end

    result.order("date DESC")
  end
  
  # search
  def self.showstats(month, projects_user, current_user)
    date = Date.today
    last_month = date - 1.month

	if month == "this_month"
	    date_used = Date.today
	elsif month == "last_month" 
	   	date_used = date - 1.month
	end
	if projects_user.present?
		result = Report.where(:project_id => projects_user.project.id, :date => date_used.beginning_of_month.to_date..date_used.end_of_month.to_date)
	else
	   services = Service.where("user_id = ?", current_user.id)
	   result = Report.where( :service_id => services, :date => date_used.beginning_of_month.to_date..date_used.end_of_month.to_date)
	end
    result.order("date DESC")
  end
  
end
