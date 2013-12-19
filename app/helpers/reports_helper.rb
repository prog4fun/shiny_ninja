# encoding: UTF-8

module ReportsHelper
  
  def get_customer_of_report(report)
    customer = report.project.customer.name
    customer = truncate(customer, :length => 25)
    return customer    
  end
  
  def billable?(report)
    return true if report.service.billable
  end
  
  # Returns total duration of one or more Reports.
  def sum_of_duration(reports)
    duration = 0
    reports.each do |report|
      duration += report.duration
    end
    return duration
  end
  
  # Returns total income of one or more Reports.
  def sum_of_income(reports)
    income = 0
    reports.each do |report|
      income += report.get_income(false)
    end
    return number_to_currency(income, :unit => "")
  end
  
end
