class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :csname
      t.string :cscode

      t.timestamps
    end
  end
end
