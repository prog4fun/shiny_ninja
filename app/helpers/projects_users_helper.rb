# encoding: UTF-8

module ProjectsUsersHelper
  
  
  def self.generate_project_token
    loop do
      token = SecureRandom.hex(20)
      break token unless ProjectsUser.where(:project_token => token).exists?
    end
  end
end
