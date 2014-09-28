class AddCreatorToModels < ActiveRecord::Migration
  def change
    add_column :bills, :creator_id, :integer
    rename_column :customers, :user_id, :creator_id
    add_column :projects, :creator_id, :integer
    add_column :reports, :creator_id, :integer
    rename_column :services, :user_id, :creator_id
  end
end
