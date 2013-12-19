class Response < ActiveRecord::Base
  attr_accessible :comment, :customer_id, :pj_name, :target_month, :target_year, :user_id, :request_questionnaire_id, :questionnaire_id
  
  has_many :response_items, :dependent => :delete_all
  accepts_nested_attributes_for :response_items
  attr_accessible :response_items_attributes
  
  belongs_to :customer
  belongs_to :user
  belongs_to :request_questionnaire
  belongs_to :questionnaire
  
  def targetYMD
    return target_year.to_s + "/" + target_month.to_s
  end
end
