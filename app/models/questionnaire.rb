class Questionnaire < ActiveRecord::Base
  
  has_and_belongs_to_many :questionitems, ->{order("id ASC") }
  
  has_many :request_questionnaires
  has_many :users, :through => :request_questionnaires
end
