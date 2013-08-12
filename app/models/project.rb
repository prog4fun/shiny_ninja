class Project < ActiveRecord::Base
  attr_accessible :comment, :customer_id, :name, :timebudget
  
  # associations
  belongs_to :customer
  
  # validations
  validates :name, :presence => true
  validates :timebudget, :presence => true
  validates :customer_id, :presence => true
end
