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
  
  # Returns a 2-D Array with Report ID's
  # Reports with the same date are in one Array.
  # Takes reports, but reports must be sorted by date to make the method working.
  # Example
  # array #= generate_array_with_equal_reports_count(reports)
  # array[3] #=> [158], [126], [128], Reports with ID 158,126,128 have the same date.
  # 3 #=> means this group of Reports is the 4th group of same dates.
  # Attention, only one Report can be a group, too, in this case.
  def generate_array_with_equal_reports_count(reports)
    array = Array.new
    z = 0
    
    # Iterates over each Report.
    reports.each_with_index do |report, index|
      
      # Checks if Report is the last one.
      unless index == (reports.count - 1)
      
        # Bundles every Report with the same an date in an Array.
        # Saves this Arrays to another Array.
        ## Checks if the current Report has the same date as the next Report.
        unless report.date == @reports[index + 1].date
          reports_with_same_dates = Array.new
        
          ## Adds all Reports with the same date to an Array
          # z #=> is the first Report which has another date that the Report before.
          for i in z..index
            reports_with_same_dates.push(reports[i].id)
          end
          z = index + 1
        
          ## Adds the Array with the same dates to the bundled Array.
          array.push(reports_with_same_dates)
        end
      else
        ## In this case this Report and if previous Reports with the same date are present,
        ## need to be save to an Array and be added to the bundled Array.
        reports_with_same_dates = Array.new
        
        for i in z..index
          reports_with_same_dates.push(reports[i].id)
        end
        array.push(reports_with_same_dates)
        
      end
    end
    
    return array
  end
  
  # Returns an Array with
  # Index #=> Report count, like 1st Report, 2nd Report and so on.
  # Attention, first Report is 0 not 1.
  # Value #=> Count of same Reports which are following.
  # Attention, if it is the 2nd equal, 3rd equal, .. Report, nil is returned.
  # Takes reports, but reports must be sorted by date to make the method working.
  # Example
  # rowspans #= generate_rowspan_for_reports(reports)
  # rowspan[5] #=> 3, means rowspan[5], rowspan[6], rowspan[7] have the same dates.
  # rowspan[6] #=> nil, rowspan[7] = nil, in this case
  # rowspan[1] #=> 1, means there's no Report with the same date.
  def generate_rowspan_for_reports(reports)
    equals_array = generate_array_with_equal_reports_count(reports)
    rowspans_array = Array.new
    
    # z #=> Elements already iterated
    z = 1
    
    # Iterates over the 2D-Array and gets an Array.
    equals_array.each do |underarray|
      # Get length of Array (same Reports count).
      underarray.count
      
      # Save length to new Array at the 'first of the same Report'
      # 'Following same Reports' (like the 2nd same and so on) stay nil
      rowspans_array[(z - 1)] = underarray.count
      
      z += underarray.count
    end
    
    return rowspans_array
  end
  
end