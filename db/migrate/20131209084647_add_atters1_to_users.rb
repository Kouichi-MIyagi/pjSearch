class AddAtters1ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :resident, :boolean
    add_column :users, :transfferred, :boolean
  end
end
