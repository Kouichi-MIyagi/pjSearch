class CreateResponseItems < ActiveRecord::Migration
  def change
    create_table :response_items do |t|
      t.integer :response_id
      t.string :question
      t.integer :selectionNumber
      t.string :selectionItem
      t.string :Comment

      t.timestamps
    end
  end
end
