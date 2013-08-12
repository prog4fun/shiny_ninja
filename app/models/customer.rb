# encoding: UTF-8

class Customer < ActiveRecord::Base
  attr_accessible :comment, :email, :name, :user_id
  
  # associations
  has_many :projects
  
  belongs_to :user
  
end
