class AddRequestQuestionnaireIdToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :request_questionnaire_id, :integer
  end
end
