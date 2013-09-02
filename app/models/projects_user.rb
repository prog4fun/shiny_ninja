class ProjectsUser < ActiveRecord::Base
  attr_accessible :project_id, :user_id
  
  # Associations
  belongs_to :project
  belongs_to :user
  
  # Validations
  validates :project_id, :user_id,
    :format => {:with => /^[^<>%&$]*$/}
  validates :project_id, :user_id, :presence => true
  validates_uniqueness_of :user_id, :scope => :project_id
  
end
