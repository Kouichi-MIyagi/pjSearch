class Questionnaire < ActiveRecord::Base
  attr_accessible :id, :effectiveFrom, :effectiveTo, :title
  
  has_and_belongs_to_many :questionitems
  
  has_many :request_questionnaires
  has_many :users, :through => :request_questionnaires
end
