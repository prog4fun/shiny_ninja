class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name,           :null => false
      t.decimal :timebudget,    :precision => 10, :scale => 2
      t.text :comment
      t.integer :customer_id,   :null => false

      t.timestamps
    end
  end
end
