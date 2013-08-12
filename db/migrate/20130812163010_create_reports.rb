class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.date :date,           :null => false
      t.decimal :duration,    :precision => 10, :scale => 2
      t.text :comment
      t.integer :project_id,  :null => false
      t.integer :service_id,  :null => false

      t.timestamps
    end
  end
end
