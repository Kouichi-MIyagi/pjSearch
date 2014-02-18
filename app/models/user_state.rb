﻿class UserState < ActiveRecord::Base
  attr_accessible :csname, :customer_id, :over_time, :request_date, :resident, :respose_date, 
    :target_month, :target_year, :transfferred, :user_id

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
#    anArray.push(self.csname)
#    anArray.push(self.targetYMD)
    anArray.push(aDate.year)
    anArray.push(aDate.month)
    anArray.push(aDate.day)
    anArray.push(aDate.next_month.year)
    anArray.push(aDate.next_month.month)
    anArray.push(1)
#    anArray.push(aDate.month)
#    anArray.push(aDate.end_of_month.day)
    return anArray
  end

  # CSVアップロード　残業時間更新用
  def UserState.from_csv(anArray)
    u = new
	csv_id = anArray[0]
    if csv_id.size < 7
      csv_id = "%07d" % anArray[0]
    end
    u.user = User.where("user_id = ?", 'p' + csv_id).first
    u.over_time = anArray[3]
    return u
  end

end
