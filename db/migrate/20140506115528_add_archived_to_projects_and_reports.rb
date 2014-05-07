class AddArchivedToProjectsAndReports < ActiveRecord::Migration
  def change
    add_column :projects, :archived, :boolean, default: false
    add_column :reports, :archived, :boolean, default: false
  end
end
