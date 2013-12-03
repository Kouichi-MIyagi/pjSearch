class Questionitem < ActiveRecord::Base
  attr_accessible :id, :question, :answer1, :answer1_item, :answer2, :answer2_item, :answer3, :answer3_item, :answer4, :answer4_item
  
  has_and_belongs_to_many :questionnaires
end
