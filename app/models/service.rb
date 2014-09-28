# encoding: UTF-8

class Service < ActiveRecord::Base
  
  # associations
  has_many :reports
  belongs_to :user
  
  # validations
  # validates :billable, :comment, :name, :user_id, :wage, :format => {:with => /^[^<>%&$]*$/}
  validates :name, :presence => true
  validates :creator_id, :presence => true
  
  # search
  def self.search(search, current_user)
    
    result = Service.where(:creator_id => current_user.id)
    
    if search
      if search["name"].present?
        result = result.where("name LIKE ?", "%" + search["name"] + "%")
      end
    end
    result.order("name ASC")
  end
end
