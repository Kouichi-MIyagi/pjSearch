class AddAnswer1ToQuestionitem < ActiveRecord::Migration
  def change
    add_column :questionitems, :answer1, :integer
    add_column :questionitems, :answer1_item, :string
    add_column :questionitems, :answer2, :integer
    add_column :questionitems, :answer2_item, :string
    add_column :questionitems, :answer3, :integer
    add_column :questionitems, :answer3_item, :string
    add_column :questionitems, :answer4, :integer
    add_column :questionitems, :answer4_item, :string
  end
end
