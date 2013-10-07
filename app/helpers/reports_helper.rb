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
  
  def get_duration(reports)
  		duration = 0
     reports.each do |report|
        duration += report.duration
     end
     return duration
  end
  
  def get_wages(reports)
  		wages = 0
     reports.each do |report|
        wages += report.service.wage
     end
     return wages
  end
  
end
