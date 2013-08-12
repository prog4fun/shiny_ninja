# encoding: UTF-8

class Report < ActiveRecord::Base
  attr_accessible :comment, :date, :duration, :project_id, :service_id
  
  # associations
  belongs_to :project
  belongs_to :service
  
  # validations
  validates :date, :presence => true
  validates :duration, :presence => true
  validates :project_id, :presence => true
  validates :service_id, :presence => true
end
