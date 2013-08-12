# encoding: UTF-8

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :registerable
  devise :database_authenticatable, :recoverable,
    :rememberable, :trackable, :validatable
  
  attr_accessible :bank_account_number, :bank_name, :bank_code, :city,
    :comment, :country, :email, :firstname, :lastname, :login, :password,
    :password_confirmation, :phone_number, :remember_me, :roles, :roles_mask, 
    :signature, :street, :street_number, :tax_number, :zipcode
  
  # associations
  has_many :customers
  
  # validations
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
  
  
  ROLES = %w[admin time_tracker project_evaluator]
  
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
  
end
