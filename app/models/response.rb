class Response < ActiveRecord::Base
  attr_accessible :attachedFile, :comment, :customer_id, :pjName, :targetMonth, :targetYear, :user_id
  
  has_many :response_items
  belongs_to :customer
end
