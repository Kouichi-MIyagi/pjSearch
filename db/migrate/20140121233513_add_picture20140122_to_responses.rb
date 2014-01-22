class AddPicture20140122ToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :picture, :string
  end
end
