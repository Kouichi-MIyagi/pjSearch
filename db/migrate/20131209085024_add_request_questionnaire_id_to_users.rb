class AddRequestQuestionnaireIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :request_questionnaire_id, :integer
  end
end
