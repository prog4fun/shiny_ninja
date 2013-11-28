class AddWageToReports < ActiveRecord::Migration
  def change
    add_column :reports, :wage, :decimal, :precision => 10, :scale => 2
  end
end
