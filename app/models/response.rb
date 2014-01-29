class Response < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  attr_accessible :comment, :customer_id, :pj_name, :target_month, :target_year, :user_id, :request_questionnaire_id, :questionnaire_id, :picture
  
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
  
  # def self.to_csv(options = {})
  def self.to_csv(responses)
    CSV.generate do |csv|
      csv << column_names
      responses.each do |res|
        csv << res.attributes.values_at(*column_names)
      end
    end
  end

  # CSVアップロード
  def self.from_csv(anArray)
    r = new
    r.id  = anArray[0]
	r.user_id = anArray[1]
	r.customer_id = anArray[2]
	r.pj_name = anArray[3].to_s.encode('utf-8', 'sjis')
	r.target_year = anArray[4]
	r.target_month = anArray[5]
	r.comment = anArray[6].to_s.encode('utf-8', 'sjis')
	r.created_at = anArray[7]
	r.updated_at = anArray[8]
	r.request_questionnaire_id = anArray[9]
	r.questionnaire_id = anArray[10]
	r.picture = anArray[11]
    return r    	
  end
  
end