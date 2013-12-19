class RemoveAttachedFileToResponse < ActiveRecord::Migration
  def up
    remove_column :responses, :attachedFile
  end

  def down
    add_column :responses, :attachedFile, :string
  end
end
