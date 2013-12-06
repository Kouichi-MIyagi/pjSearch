class AddUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_is, :string
    add_index :users, :user_is, :unique => true
  end
end
