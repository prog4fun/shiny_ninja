class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name,           :null => false
      t.decimal :wage,          :precision => 10, :scale => 2
      t.boolean :billable
      t.text :comment
      t.integer :user_id,       :null => false

      t.timestamps
    end
  end
end
