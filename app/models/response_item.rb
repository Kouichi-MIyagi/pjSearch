class ResponseItem < ActiveRecord::Base
  attr_accessible :comment, :question, :response_id, :selection_item, :selection_number
  
  belongs_to :response
end
