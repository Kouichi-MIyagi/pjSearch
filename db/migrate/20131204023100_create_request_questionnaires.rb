class CreateRequestQuestionnaires < ActiveRecord::Migration
  def change
    create_table :request_questionnaires do |t|
      t.integer :user_id
      t.integer :questionnaire_id
      t.integer :target_year
      t.integer :target_month

      t.timestamps
    end
  end
end
