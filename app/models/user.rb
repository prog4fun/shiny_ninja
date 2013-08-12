class User < ActiveRecord::Base
  attr_accessible :bank_account_number, :bank_name, :bank_number_code, :city,
    :country, :email, :firstname, :lastname, :login, :password, :phone_number,
    :roles, :signatur_path, :street, :street_number, :taxnumber, :zipcode
  # :roles_mask
  
  class User < ActiveRecord::Base
    ROLES = %w[admin time_tracker project_evaluator]
  end
  
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
