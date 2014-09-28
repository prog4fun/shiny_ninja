class Bill < ActiveRecord::Base
  
  
  # associations
  belongs_to :customer
  belongs_to :user, foreign_key: :creator_id


  # validations
 # validates :amount, :comment, :customer_id, :date, :month, :number, :paid, :year, :format => {:with => /^[^<>%&$]*$/}
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
    number_digits = Array.new
    
    positions = Array.new
    bill_count = (Bill.count(:all) + 1).to_s

    i = 0    
    while i < bill_count.length do
      positions.push(bill_count[i])
      i += 1
    end
    
    number_digits.push(positions)
    
    time = Time.now
    hours = time.strftime("%H")
    minutes = time.strftime("%M")

    number_digits.push(hours[0].to_s)
    number_digits.push(hours[1].to_s)
    number_digits.push(minutes[0].to_s)
    number_digits.push(minutes[1].to_s)
    
    number_digits.flatten!
    number_digits.shuffle!
    
    number = number_digits.join
    return number
  end
  
  # search
  def self.search(search, current_user)
    
    # customers = current_user.customers
    # result = Bill.where( :customer_id => customers )

    result = current_user.bills
    
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
