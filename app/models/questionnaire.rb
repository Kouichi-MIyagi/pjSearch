class Questionnaire < ActiveRecord::Base
  attr_accessible :effectiveFrom, :effectiveTo, :id, :title
end
