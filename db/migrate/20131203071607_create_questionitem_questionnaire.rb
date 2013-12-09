class CreateQuestionitemQuestionnaire < ActiveRecord::Migration
  def up
    create_table :questionitems_questionnaires, :id => false do |t|
      t.references :questionitem
      t.references :questionnaire
    end
  end

  def down
    drop_table :questionitems_questionnaires
  end
end
