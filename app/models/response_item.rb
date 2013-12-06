class ResponseItem < ActiveRecord::Base
  attr_accessible :Comment, :question, :response_id, :selectionItem, :selectionNumber
  
  belongs_to :response
end
