# encoding: UTF-8

class ProjectsUser < ActiveRecord::Base
  attr_accessible :project_id, :user_id, :project_token, :confirmation_email
  
  # Associations
  belongs_to :project
  belongs_to :user
  
  # Validations
  validates :project_id, :user_id, :project_token, :confirmation_email,
    :format => {:with => /^[^<>%&$]*$/}
  validates :project_id, :presence => true
  validates :confirmation_email, :presence => true, :on => :create 
  validates :confirmation_email, :uniqueness => {:case_sensitive => false, :scope => :project_id}  
end
