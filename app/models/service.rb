# encoding: UTF-8

class Service < ActiveRecord::Base
  attr_accessible :billable, :comment, :name, :user_id, :wage
  
  # associations
  has_many :reports
  belongs_to :user
  
  # validations
  validates :name, :presence => true
  validates :user_id, :presence => true
  
  # search
  def self.search(search, current_user)
    
    result = Service.where("user_id = ?", current_user.id)
    
    if search
      if search["name"].present?
        result = result.where("name LIKE ?", search["name"])
      end
    end
    result.order("name ASC")
  end
end
