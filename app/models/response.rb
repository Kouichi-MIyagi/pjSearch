class Response < ActiveRecord::Base
  attr_accessible :attachedFile, :comment, :customer_id, :pjName, :targetMonth, :targetYear, :user_id
  
  has_many :response_items, :dependent => :delete_all
  accepts_nested_attributes_for :response_items
  attr_accessible :response_items_attributes
  
  belongs_to :customer
  belongs_to :user
  
  def targetYMD
    return targetYear.to_s + "/" + targetMonth.to_s
  end
end
