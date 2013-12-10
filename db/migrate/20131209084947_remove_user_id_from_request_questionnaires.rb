class RemoveUserIdFromRequestQuestionnaires < ActiveRecord::Migration
  def up
    remove_column :request_questionnaires, :user_id
  end

  def down
    add_column :request_questionnaires, :user_id, :string
  end
end
