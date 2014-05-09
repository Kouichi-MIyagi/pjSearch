namespace :csv_to_db do
  desc "insert DB From CSVFile"
  # call UserStatesController.CsvToUserStates
  # $ rake csv_to_db:user_states['2014','4','tmp/uploads/xxxxx.csv'] 

    task :user_states, ['targetYear', 'targetMonth', 'filePath'] => :environment do |task, args|
	  require 'csv'
      require 'kconv'	  
#	  puts args.filePath
	  puts "#{Time.now} -- csv_to_db:user_states start !!"

	  reader = File.read(args.filePath)
	  
	  _UserStatesController = UserStatesController.new
	  _UserStatesController.CsvToUserStates(args.targetYear,args.targetMonth,reader)
	  
	  puts "#{Time.now} -- user_states inserted !!"

	end

  desc "clear CSVFile"
  # Truncates args.filepath to zero byte
  # $ rake csv_to_db:clear['tmp/uploads/xxxxx.csv'] のように使う
  # 

	task :clear, ['filePath'] => :environment do |task, args|
	  f = File.open(args.filePath, "w")
	  f.close
	  puts "#{Time.now} -- #{args.filePath} -- clear !!"
	end

end
