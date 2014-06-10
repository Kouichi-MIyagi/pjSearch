class AddMcTimeToUserState < ActiveRecord::Migration
  def change
    add_column :user_states, :mc_time, :float
  end
end
