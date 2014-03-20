class ChangeContentsFormatToTopic < ActiveRecord::Migration
  def up
    change_column :topics, :contents, :text, :limit => nil
  end

  def down
    change_column :topics, :contents, :string
  end
end
