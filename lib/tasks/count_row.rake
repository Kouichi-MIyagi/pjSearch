namespace :db do
  namespace :row do
  desc "count row From DB"
  # call UserStatesController.CsvToUserStates
  # $ rake db:row:count 
    task :count => :environment do
	  skip_tables = ["schema_info", "schema_migrations", "sessions"]
	  # カウント対象外のDBを除く
	  table_names = (ActiveRecord::Base.connection.tables - skip_tables)
	
	  table_names.each do |table_name|
        rows = ActiveRecord::Base.connection.select_all("SELECT count(*) FROM #{table_name}")
		res = rows.to_s.match(%r(\d+)).to_s
        puts "#{table_name.ljust(30)}#{res}"
		#puts "#{table_name.ljust(30)}#{rows[0].fetch('count(*)')}"
	  end
	end
  end
end
