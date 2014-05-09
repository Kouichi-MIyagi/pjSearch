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
	    sql = "SELECT count(*) as rows FROM #{table_name}"
		res = ActiveRecord::Base.connection.select_all(sql)
        puts "#{table_name.ljust(30)}#{res}"
	  end
	end
  end
end
