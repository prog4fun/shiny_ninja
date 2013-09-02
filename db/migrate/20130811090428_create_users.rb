class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login,      :null => false
      t.string :firstname
      t.string :lastname
      t.string :email,      :null => false
      t.string :phone_number
      t.string :street
      t.string :street_number
      t.string :zipcode
      t.string :city
      t.string :country
      t.string :bank_name
      t.string :bank_code
      t.string :bank_account_number
      t.string :tax_number
      t.string :signature
      t.text :comment
      t.integer :roles_mask
      t.integer :created_by, :null => false
    
      t.timestamps
    end
  end
end
