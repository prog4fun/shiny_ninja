module BillsHelper
  
  def get_pulldown_month(object_name, method_name, selected_value)
    value_key_pairs = [
      [t("labels.universe.unknown"), Bill::MONTH_UNKNOWN],
      [t("date.month_names.january"), Bill::JANUARY],
      [t("date.month_names.february"), Bill::FEBRUARY],
      [t("date.month_names.march"), Bill::MARCH],
      [t("date.month_names.april"), Bill::APRIL],
      [t("date.month_names.may"), Bill:: MAY],
      [t("date.month_names.june"), Bill::JUNE],
      [t("date.month_names.july"), Bill::JULY],
      [t("date.month_names.august"), Bill::AUGUST],
      [t("date.month_names.september"), Bill::SEPTEMBER],
      [t("date.month_names.october"), Bill::OCTOBER],
      [t("date.month_names.november"), Bill::NOVEMBER],
      [t("date.month_names.december"), Bill::DECEMBER], ]
    select object_name, method_name, value_key_pairs, {:selected => selected_value}, {:class => "form-control"}
  end
  
  def label_for_month(month)
    case month
    when Bill::JANUARY
      return t("date.month_names.january")  
    when Bill::FEBRUARY
      return t("date.month_names.february")  
    when Bill::MARCH
      return t("date.month_names.march")  
    when Bill::APRIL
      return t("date.month_names.april")
    when Bill:: MAY
      return t("date.month_names.may")
    when  Bill::JUNE
      return t("date.month_names.june")
    when Bill::JULY
      return t("date.month_names.july")
    when Bill::AUGUST
      return t("date.month_names.august")
    when Bill::SEPTEMBER
      return t("date.month_names.september")
    when Bill::OCTOBER
      return t("date.month_names.october")
    when Bill::NOVEMBER
      return t("date.month_names.november")
    when Bill::DECEMBER
      return t("date.month_names.december")
    else  
      return t("standards.unknown") 
    end 
  end
  
  def get_current_year
    year = Time.now.strftime("%Y")
    return year
  end
  
  def create_bill_number
    time = Time.now
  
    position = Bill.count(:all)
    position =+ 1
    position.to_s
    
    hours = time.strftime("%H")
    minutes = time.strftime("%M")
    
    first = hours[1].to_s
    second = position[0].to_s
    third = hours[0].to_s
    fourth = minutes[1].to_s
    fifth = position[1].to_s
    sixth =minutes[0].to_s

    number = first + second + third + fourth + fifth + sixth
    return number
  end
  
end
