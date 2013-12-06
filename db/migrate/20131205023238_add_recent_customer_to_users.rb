class AddRecentCustomerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recent_customer, :string
  end
end
