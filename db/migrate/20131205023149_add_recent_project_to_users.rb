class AddRecentProjectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recent_project, :string
  end
end
