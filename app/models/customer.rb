# encoding: UTF-8

class Customer < ActiveRecord::Base
  attr_accessible :comment, :email, :name, :user_id
  
  # associations
  has_many :projects
  belongs_to :user
  
  # validations
  validates :name, :presence => true
  validates :email, :presence => true
  validates :user_id, :presence => true
  
end
