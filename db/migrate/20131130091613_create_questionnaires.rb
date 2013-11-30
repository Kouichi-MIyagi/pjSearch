class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.integer :id
      t.string :title
      t.date :effectiveFrom
      t.date :effectiveTo

      t.timestamps
    end
  end
end
