class AddUserId2ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_is, :string
  end
end
