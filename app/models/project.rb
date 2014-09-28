# encoding: UTF-8

class Project < ActiveRecord::Base

  # associations
  belongs_to :customer
  has_many :evaluators, through: :projects_users, source: :user
  has_many :reports

  belongs_to :user, foreign_key: :creator_id

  # validations
  # validates :comment, :customer_id, :name, :timebudget, :format => {:with => /^[^<>%&$]*$/}
  validates :name, :presence => true
  validates :customer_id, :presence => true

  # search
  def self.search(search, current_user)

    # customers = current_user.customers
    # result = Project.where(:customer_id => customers)

    result = current_user.projects

    if search
      if search["name"].present?
        result = result.where('name LIKE ?', "%" + search["name"] + "%")
      end
      if search["customer"].present?
        result = result.where('customer_id = ?', search["customer"])
      end
      # archived, will return nil if 'all' is selected.
      if search["archived"] == 'false'
        result = result.where('archived = ?', false)
      end
      if search["archived"] == 'true'
        result = result.where('archived = ?', true)
      end
    end
    result.order("name")
  end

  def reports_worked
    Report.all.where(project_id: id)
  end
end
