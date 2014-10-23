class Status < ActiveRecord::Base
  
  def MentenanceMode
    self.is_mentenance ? "メンテナンス中" : "通常稼働中です"
  end
end
