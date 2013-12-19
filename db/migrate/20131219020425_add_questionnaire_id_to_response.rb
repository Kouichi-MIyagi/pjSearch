class AddQuestionnaireIdToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :questionnaire_id, :integer
  end
end
