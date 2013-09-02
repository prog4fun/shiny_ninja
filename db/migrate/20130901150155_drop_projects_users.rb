class DropProjectsUsers < ActiveRecord::Migration
  def up
    drop_table :projects_users
  end

  def down
    create_table :projects_users, :id => false do |t|
      t.references :project, :user
    end
  end
end
