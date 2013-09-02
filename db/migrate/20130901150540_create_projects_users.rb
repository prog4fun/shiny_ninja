class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :projects_users do |t|
      t.belongs_to :project, :null => false
      t.belongs_to :user, :null => false

      t.timestamps
    end
  end
end
