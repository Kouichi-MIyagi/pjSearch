class CreateUploadedUserStates < ActiveRecord::Migration
  def change
    create_table :uploaded_user_states do |t|
      t.string :comment

      t.timestamps
    end
  end
end
