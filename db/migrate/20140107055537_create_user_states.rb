class CreateUserStates < ActiveRecord::Migration
  def change
    create_table :user_states do |t|
      t.integer :user_id
      t.integer :customer_id
      t.integer :target_year
      t.integer :target_month
      t.float :over_time
      t.boolean :resident
      t.boolean :transfferred
      t.date :request_date
      t.date :respose_date
      t.string :csname

      t.timestamps
    end
  end
end
