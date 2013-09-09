class AddProjectTokenToProjectsUsers < ActiveRecord::Migration
  
  def change
    change_table :projects_users do |t|
      t.remove :user_id     # needs to be nil at some point
      t.integer :user_id
      t.string :project_token
      t.string :confirmation_email
    end
  end

end
