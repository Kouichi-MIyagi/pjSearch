class AddAttrs1ToRequestQuestionnaire < ActiveRecord::Migration
  def change
    add_column :request_questionnaires, :mail_tilte, :string
    add_column :request_questionnaires, :mail_banner, :text
    add_column :request_questionnaires, :mail_content, :text
    add_column :request_questionnaires, :mail_trailer, :text
    add_column :request_questionnaires, :day_of_mail_sent, :date
  end
end
