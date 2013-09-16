class DeleteUnnecessaryUserFields < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :bank_name
      t.remove :bank_code
      t.remove :bank_account_number
      t.remove :tax_number
      
    end
  end
end
