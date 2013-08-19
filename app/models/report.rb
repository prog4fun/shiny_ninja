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
  
  # search
  def self.search(search, current_user)
    
    if current_user.is? :project_evaluator
      projects = current_user.projects
      result = Report.where( :project_id => projects)
    else
      services = Service.where("user_id = ?", current_user.id)
      result = Report.where( :service_id => services)
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
  
end
