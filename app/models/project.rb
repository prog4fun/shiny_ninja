class Project < ActiveRecord::Base
  attr_accessible :comment, :customer_id, :name, :timebudget
  
  # associations
  belongs_to :customer
end
