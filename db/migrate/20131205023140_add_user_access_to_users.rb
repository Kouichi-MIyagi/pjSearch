class AddUserAccessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_access, :string
  end
end
