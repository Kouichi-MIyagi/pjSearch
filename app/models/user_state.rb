class UserState < ActiveRecord::Base

  belongs_to :user
  belongs_to :customer
  
  def targetYMD
    return target_year.to_s + "/" + target_month.to_s
  end
  
  def asTimelineRow
    # なぜかGoogle chart timelineは1か月ずれて表示されるので、補正しています。
	aDate = Date.new(target_year, target_month,1) << 1
	#aDate = Date.new(target_year, target_month,1)
    
    anArray = Array.new()
    anArray.push("常駐先")
    anArray.push(self.csname)
    anArray.push(aDate.year)
    anArray.push(aDate.month)
    anArray.push(aDate.day)
    anArray.push(aDate.next_month.year)
    anArray.push(aDate.next_month.month)
    anArray.push(1)
    return anArray
  end

  # CSVアップロード　残業時間更新用
  def UserState.from_csv(anArray, targetYear, targetMonth)
    csv_id = anArray[0]
	if csv_id.size < 7
       csv_id = "%07d" % anArray[0]
    end	
	
	current_u = User.find_by_user_id('p'.concat(csv_id))
	if current_u.nil?
	  return nil
	end
	
    u = UserState.find_by_user_id_and_target_year_and_target_month(current_u.id,targetYear,targetMonth)
	#User_Stateが存在した場合、残業時間などをセット
	if !u.blank?
	  u.over_time = anArray[2]
      u.mc_time = anArray[3]
	end
	
	return u
  end

  def self.to_csv(user_state)
    CSV.generate do |csv|
      csv << "社員番号,社員名,年,月,残業時間,長時間検診用時間,客先常駐,出向,顧客名,request_date,respose_date,id,直近の顧客".parse_csv
      user_state.each do |u|
		#CSV出力
        csv << [u.user.user_id, u.user.user_name, u.target_year, u.target_month, u.over_time, u.mc_time, u.user.resident, u.user.transfferred,
			u.csname, u.request_date, u.respose_date, u.id, u.user.recent_customer]
      end
    end
  end

end
