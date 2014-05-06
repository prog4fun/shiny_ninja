class AddWageToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :wage, :decimal, precision: 10, scale: 2
  end
end
