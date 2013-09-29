class Bill < ActiveRecord::Base
  attr_accessible :amount, :comment, :customer_id, :date, :month, :number, :paid, :year
end
