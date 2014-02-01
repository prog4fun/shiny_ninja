# encoding: UTF-8

class Customer < ActiveRecord::Base
  
  # associations
  has_many :bills
  has_many :projects
  belongs_to :user
  
  # validations
 # validates :comment, :email, :name, :user_id, :format => {:with => /^[^<>%&$]*$/}
  validates :name, :presence => true
  validates :email, :presence => true
  #,:format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}
  validates :user_id, :presence => true
  
  # search
  def self.search(search, current_user)
    
    result = current_user.customers
    
    if search
      if search["name"].present?
        result = result.where('name LIKE ?', "%" + search["name"] + "%")
      end
      if search["email"].present?
        result = result.where('email LIKE ?', "%" + search["email"] + "%")
      end    
    end
    result.order("name")
  end
  
end
