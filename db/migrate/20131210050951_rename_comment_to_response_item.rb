class RenameCommentToResponseItem < ActiveRecord::Migration
  def up
    rename_column :response_items, :Comment, :comment
    rename_column :response_items, :selectionNumber, :selection_number
    rename_column :response_items, :selectionItem, :selection_item
  end

  def down
    rename_column :response_items, :comment, :Comment
	rename_column :response_items, :selection_number, :selectionNumber
    rename_column :response_items, :selection_item, :selectionItem
  end
end
