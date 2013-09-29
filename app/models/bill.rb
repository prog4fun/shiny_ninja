class Bill < ActiveRecord::Base
  attr_accessible :amount, :comment, :customer_id, :date, :month, :number, :paid, :year
  
  
  # associations
  belongs_to :customer
  
  # validations
  validates :amount, :comment, :customer_id, :date,
    :month, :number, :paid, :year, :format => {:with => /^[^<>%&$]*$/}
  validates :number, :presence => true
  validates :date, :presence => true
  validates :amount, :presence => true
  validates :customer_id, :presence => true
  
  MONTH_UNKNOWN = 0
  JANUARY = 1
  FEBRUARY = 2
  MARCH = 3
  APRIL = 4
  MAY = 5
  JUNE = 6
  JULY = 7
  AUGUST = 8
  SEPTEMBER = 9
  OCTOBER = 10
  NOVEMBER = 11
  DECEMBER =12
  
  def self.generate_bill_number
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
  
  # search
  def self.search(search, current_user)
    
    customers = current_user.customers
    result = Bill.where( :customer_id => customers )
    
    if search
      if search["number"].present?
        result = result.where('number LIKE ?', "%" + search["number"] + "%")
      end
      if search["date_from"].present?
        result = result.where("date >= ?", search["date_from"].to_date)
      end
      if search["date_to"].present?
        result = result.where("date <= ?", search["date_to"].to_date)
      end
      if search["customer"].present?
        result = result.where('customer_id = ?', search["customer"])
      end
    end
    result.order("date DESC")
  end
  
end
