class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :customer_id
      t.string :pjName
      t.integer :targetYear
      t.integer :targetMonth
      t.string :comment
      t.string :attachedFile

      t.timestamps
    end
  end
end
