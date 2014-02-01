class Status < ActiveRecord::Base
  attr_accessible :is_mentenance
  
  def MentenanceMode
    self.is_mentenance ? "メンテナンス中" : "通常稼働中です"
  end
end
