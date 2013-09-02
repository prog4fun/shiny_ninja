# encoding: UTF-8

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :registerable, :validatable
  devise :database_authenticatable, :recoverable,
    :rememberable, :trackable
  
  attr_accessible :bank_account_number, :bank_name, :bank_code, :city,
    :comment, :country, :created_by, :email, :firstname, :lastname, :login,
    :password, :password_confirmation, :phone_number, :remember_me, :roles,
    :roles_mask, :signature, :street, :street_number, :tax_number, :zipcode
  
  # associations
  has_many :customers
  has_many :services
  has_many :projects_users
  has_many :projects, :through => :projects_users
  
  # validations
  validates :bank_account_number, :bank_name, :bank_code, :city,
    :comment, :country, :created_by, :email, :firstname, :lastname, :login,
    :password, :password_confirmation, :phone_number, :remember_me, :roles,
    :roles_mask, :signature, :street, :street_number, :tax_number, :zipcode,
    :format => {:with => /^[^<>%&$]*$/}
  
  validates :login, :presence => true,
    :uniqueness => {:case_sensitive => false}
  validates :password, :length => { :minimum => 5, :maximum => 40},
    :confirmation => true,
    :on => :create
  validates :password, :length => { :minimum => 5, :maximum => 40},
    :confirmation => true,
    :allow_blank => true,
    :on => :update
  validates :email, :presence => true,
    :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/},
    :uniqueness => {:case_sensitive => false}
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  
  # if you change the order here, change users_controller --> create (default-id)!
  ROLES = %w[administrator time_tracker project_evaluator]
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end
  
  def is?(role)
    roles.include?(role.to_s)
  end
  
  # search
  def self.search(search)
    result = User
    if search
      if search["firstname"].present?
        result = result.where("firstname LIKE ?", "%" + search["firstname"] + "%")
      end
      if search["lastname"].present?
        result = result.where("lastname LIKE ?", "%" + search["lastname"] + "%")
      end
    end
    result.order("lastname ASC")
  end
end
