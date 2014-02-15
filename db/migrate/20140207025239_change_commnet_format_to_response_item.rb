class ChangeCommnetFormatToResponseItem < ActiveRecord::Migration
  def up
    change_column :response_items, :comment, :text, :limit => nil
  end

  def down
    change_column :response_items, :comment, :string
  end
end
