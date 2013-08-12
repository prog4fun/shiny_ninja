# encoding: UTF-8

class Service < ActiveRecord::Base
  attr_accessible :billable, :comment, :name, :user_id, :wage
  
  # associations
  has_many :reports
  belongs_to :user
  
    # validations
  validates :name, :presence => true
  validates :user_id, :presence => true
end
