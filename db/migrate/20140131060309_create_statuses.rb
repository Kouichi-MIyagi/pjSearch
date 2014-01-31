class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.boolean :is_mentenance

      t.timestamps
    end
  end
end
