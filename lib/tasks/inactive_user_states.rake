namespace :inactive_user_states do
desc "UserStateから対象年月のレコードを削除" 

# $ rake inactive_user_states:destroy_yyyymm['2014','4']

    task :destroy_yyyymm, ['targetYear', 'targetMonth'] => :environment do |task, args|
		puts "#{Time.now} -- inactive_user_states:destroy_yyyymm start !!"

		_targetYear=  args.targetYear.to_i
		_targetMonth=  args.targetMonth.to_i
		_counter = 0
		
        UserState.find_each do |us|
          if (us.target_year == _targetYear && us.target_month == _targetMonth)
            us.destroy
			_counter = _counter + 1
		  end
        end
		
	    puts "#{Time.now} -- #{_counter} user_states deleted !!"

    end
end
