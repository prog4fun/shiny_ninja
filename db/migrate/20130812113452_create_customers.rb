class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email, :null => false
      t.text :comment
      t.integer :user_id

      t.timestamps
    end
  end
end
