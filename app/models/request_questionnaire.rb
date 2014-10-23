class RequestQuestionnaire < ActiveRecord::Base
  
  belongs_to :questionnaire
  has_many :users
  has_many :responses

  # 現在のアンケート依頼を返す。
  def self.current_request
    # ターゲット年月の降順でselectし、一件目を返す。
    # 次月分を先に作っておいた場合に考慮が必要
    return self.all( :order => 'target_year desc, target_month desc' ).first
  end

  def collectMailAddrs
    destination = ""
    self.users.each do | user |
      destination = destination + user.myMailAddress + ';'
    end
    return destination
  end
  
end
