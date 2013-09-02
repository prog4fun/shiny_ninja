class RemoveCreatedByFromUsers < ActiveRecord::Migration
  
  def change
    change_table :users do |t|
      t.remove :created_by
    end
  end

end
