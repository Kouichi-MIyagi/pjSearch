class AddRecentResidentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recent_resident, :string
  end
end
