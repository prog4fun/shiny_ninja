# encoding: UTF-8

class Project < ActiveRecord::Base

  # associations
  belongs_to :customer
  has_many :projects_users
  has_many :users, :through => :projects_users

  # validations
  # validates :comment, :customer_id, :name, :timebudget, :format => {:with => /^[^<>%&$]*$/}
  validates :name, :presence => true
  validates :customer_id, :presence => true

  # search
  def self.search(search, current_user)

    customers = current_user.customers
    result = Project.where(:customer_id => customers)

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
end
