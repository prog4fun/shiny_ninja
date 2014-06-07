class CreateTestmodels < ActiveRecord::Migration
  def change
    create_table :testmodels do |t|
      t.string :teststring
      t.boolean :testcheck
      t.int :testnumber

      t.timestamps
    end
  end
end
