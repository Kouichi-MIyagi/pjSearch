class CreateQuestionitems < ActiveRecord::Migration
  def change
    create_table :questionitems do |t|
      t.integer :id
      t.string :question
      t.integer :selectionNumber
      t.string :questionItem

      t.timestamps
    end
  end
end
