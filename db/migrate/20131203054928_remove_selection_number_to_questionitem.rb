class RemoveSelectionNumberToQuestionitem < ActiveRecord::Migration
  def up
    remove_column :questionitems, :selectionNumber
    remove_column :questionitems, :questionItem
  end

  def down
    add_column :questionitems, :questionItem, :string
    add_column :questionitems, :selectionNumber, :integer
  end
end
