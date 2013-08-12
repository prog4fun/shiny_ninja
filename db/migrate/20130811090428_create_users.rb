class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password
      t.string :phone_number
      t.string :street
      t.string :street_number
      t.string :zipcode
      t.string :city
      t.string :country
      t.string :bank_name
      t.string :bank_number_code
      t.string :bank_account_number
      t.string :taxnumber
      t.string :signatur_path
      t.integer :roles_mask

      t.timestamps
    end
  end
end
