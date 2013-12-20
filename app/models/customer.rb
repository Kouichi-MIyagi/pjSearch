class Customer < ActiveRecord::Base
  attr_accessible :cscode, :csname
  
  #未入力でないこと
  validates :csname, presence: true
end
