module BillsHelper
  
  def get_pulldown_month(object_name, method_name, selected_value)
    value_key_pairs = [
      [t("labels.universe.unknown"), Bill::MONTH_UNKNOWN],
      [t("date.month_names")[0], Bill::JANUARY],
      [t("date.month_names")[1], Bill::FEBRUARY],
      [t("date.month_names")[2], Bill::MARCH],
      [t("date.month_names")[3], Bill::APRIL],
      [t("date.month_names")[4], Bill:: MAY],
      [t("date.month_names")[5], Bill::JUNE],
      [t("date.month_names")[6], Bill::JULY],
      [t("date.month_names")[7], Bill::AUGUST],
      [t("date.month_names")[8], Bill::SEPTEMBER],
      [t("date.month_names")[9], Bill::OCTOBER],
      [t("date.month_names")[10], Bill::NOVEMBER],
      [t("date.month_names")[11], Bill::DECEMBER], ]
    select object_name, method_name, value_key_pairs, {:selected => selected_value}, {:class => "form-control"}
  end
  
  def label_for_month(month)
    case month
    when Bill::JANUARY
      return t("date.month_names")[0]
    when Bill::FEBRUARY
      return t("date.month_names")[1]
    when Bill::MARCH
      return t("date.month_names")[2]
    when Bill::APRIL
      return t("date.month_names")[3]
    when Bill:: MAY
      return t("date.month_names")[4]
    when  Bill::JUNE
      return t("date.month_names")[5]
    when Bill::JULY
      return t("date.month_names")[6]
    when Bill::AUGUST
      return t("date.month_names")[7]
    when Bill::SEPTEMBER
      return t("date.month_names")[8]
    when Bill::OCTOBER
      return t("date.month_names")[9]
    when Bill::NOVEMBER
      return t("date.month_names")[10]
    when Bill::DECEMBER
      return t("date.month_names")[11]
    else  
      return t("standards.unknown") 
    end 
  end
  
  def get_current_year
    year = Time.now.strftime("%Y")
    return year
  end
  
end
