class AddPicture20140122ToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :picture, :string
  end
end
