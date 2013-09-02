class RemoveCreatedByFromUsers < ActiveRecord::Migration
  change_table :users do |t|
    t.remove :created_by
  end
end
