# encoding: UTF-8

class Customer < ActiveRecord::Base
  attr_accessible :comment, :email, :name, :user_id
end
