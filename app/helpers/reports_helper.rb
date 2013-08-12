# encoding: UTF-8

module ReportsHelper
  
  def get_customer_of_report(report)
    customer = report.project.customer.name
    customer = truncate(customer, :length => 20)
    return customer    
  end
  
  def billable?(report)
    return true if report.service.billable
  end
  
end
