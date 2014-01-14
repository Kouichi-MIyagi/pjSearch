class AddRegidentEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :resident_email, :string
  end
end
