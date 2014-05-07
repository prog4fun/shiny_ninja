# encoding: UTF-8

class Report < ActiveRecord::Base

  # associations
  belongs_to :project
  belongs_to :service

  # validations
  # validates :comment, :date, :duration, :project_id, :service_id, :format => {:with => /^[^<>%&$]*$/}
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
            report.duration.to_s.gsub(".", ","),
            report.comment]
        # csv << report.attributes.values_at(*column_names)
        csv << data
      end
    end
  end

  # Returns the wage in currency format.
  def get_wage
    return number_to_currency(self.wage)
  end

  # Returns the wage in readable format.
  def get_duration
    return "#{self.duration.to_s.sub!('.', ',')} #{I18n.t("labels.datetime.hour_short")}"
  end

  # Calculates and returns the income (wage + duration) of the current Report.
  # Readable can be set to false if it is necessary to calculate with the result.
  # readable false => returns number instead of a string.
  def get_income(readable = true)
    income = self.wage * self.duration
    if readable
      return number_to_currency(self.wage * self.duration)
    else
      return income
    end
  end

  # search
  def self.search(search, projects_user, current_user)

    if projects_user.present?
      result = Report.where(:project_id => projects_user.project.id)
    else
      services = Service.where("user_id = ?", current_user.id)
      result = Report.where(:service_id => services)
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
        projects_of_customer = Project.where('customer_id = ?', search["customer"])
        result = result.where(:project_id => projects_of_customer)
      end
      if search["project"].present?
        result = result.where('project_id = ?', search["project"])
      end
      # archived, will return nil if 'all' is selected.
      if search["archived"] == 'false'
        result = result.where('archived = ?', false)
      end
      if search["archived"] == 'true'
        result = result.where('archived = ?', true)
      end
    end
    result.order("date DESC")
  end

  # statistic
  def self.showstats(month, projects_user, current_user)
    if projects_user.present?
      result = Report.where(:project_id => projects_user.project.id, :date => month)
    else
      services = Service.where("user_id = ?", current_user.id)
      result = Report.where(:service_id => services, :date => month)
    end
  end

end
