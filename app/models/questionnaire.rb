class Questionnaire < ActiveRecord::Base
  attr_accessible :id, :effectiveFrom, :effectiveTo, :title
  
  has_and_belongs_to_many :questionitems
end
