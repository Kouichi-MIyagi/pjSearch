class AddAttrs1216ToRequestQuestionnaire < ActiveRecord::Migration
  def change
    add_column :request_questionnaires, :resident, :string
    add_column :request_questionnaires, :transfferred, :string
  end
end
