class ChangeCommnetFormatToResponse < ActiveRecord::Migration
  def up
    change_column :responses, :comment, :text, :limit => nil
  end

  def down
      change_column :responses, :comment, :string
  end
end
