class RequestQuestionnaire < ActiveRecord::Base
  attr_accessible :questionnaire_id, :target_month, :target_year, :user_id
  
  belongs_to :questionnaire
  belongs_to :user
end
