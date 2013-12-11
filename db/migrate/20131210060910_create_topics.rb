class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :contents
      t.date :effective_to

      t.timestamps
    end
  end
end
