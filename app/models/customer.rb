class Customer < ActiveRecord::Base
  
  #未入力でないこと
  validates :csname, presence: true
end
