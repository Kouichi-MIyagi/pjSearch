class RequestQuestionnaire < ActiveRecord::Base
  attr_accessible :questionnaire_id, :target_month, :target_year, :user_id
  
  belongs_to :questionnaire
  has_many :user

  # 現在のアンケート依頼を返す。
  def self.current_request
    # ターゲット年月の降順でselectし、一件目を返す。
    # 次月分を先に作っておいた場合に考慮が必要
    return self.all( :order => 'target_year desc, target_month desc' ).first
  end

end
