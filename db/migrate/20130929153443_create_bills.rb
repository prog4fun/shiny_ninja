class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :number, :null => false
      t.date :date, :null => false
      t.decimal :month
      t.decimal :year
      t.decimal :amount, :precision => 10, :scale => 2, :null => false
      t.boolean :paid
      t.text :comment
      t.integer :customer_id, :null => false

      t.timestamps
    end
  end
end
