class AddCsvfileToUploadedUserState < ActiveRecord::Migration
  def change
    add_column :uploaded_user_states, :csvfile, :string
  end
end
