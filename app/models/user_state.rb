class UserState < ActiveRecord::Base
  attr_accessible :csname, :customer_id, :over_time, :request_date, :resident, :respose_date, 
    :target_month, :target_year, :transfferred, :user_id

  belongs_to :user
  belongs_to :customer
  
  def targetYMD
    return target_year.to_s + "/" + target_month.to_s
  end
end
