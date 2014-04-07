class Response < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  attr_accessible :comment, :customer_id, :pj_name, :target_month, :target_year, :user_id, :request_questionnaire_id, :questionnaire_id, :picture
  
  has_many :response_items, :dependent => :delete_all, :order => 'id ASC'
  accepts_nested_attributes_for :response_items
  attr_accessible :response_items_attributes
  
  belongs_to :customer
  belongs_to :user
  belongs_to :request_questionnaire
  belongs_to :questionnaire
  
  def targetYMD
    return target_year.to_s + "/" + target_month.to_s
  end
  
  def aPartOfCommnet
    return self.comment.length < 20 ? self.comment : self.comment[0,20]+"..."
  end
  
  # def self.to_csv(options = {})
  def self.to_csv(responses)
    CSV.generate do |csv|
      csv << "response?".parse_csv + column_names + "社員名,顧客名,社員番号".parse_csv
      responses.each do |res|
		#回答の出力
        csv << [true, res.id, res.user_id, res.customer_id, res.pj_name, res.target_year, 
		        res.target_month, res.comment, res.created_at, res.updated_at,
				res.request_questionnaire_id, res.questionnaire_id, res.picture,
				res.user.user_name,res.customer.csname,res.user.user_id]
		#回答明細分の出力
		res.response_items.each do |res_i|
		  csv << [false,res_i.id, res_i.response_id, res_i.question, res_i.selection_number, 
		          res_i.selection_item, res_i.comment, res_i.created_at, res_i.updated_at]
		end
      end
    end
  end

  # CSVアップロード
  def self.from_csv(anArray)
    r = new
	#1列目（anArray[0]）は親子区分
    r.id  = anArray[1]
	r.user_id = anArray[2]
	r.customer_id = anArray[3]
	r.pj_name = anArray[4].to_s.encode('utf-8', 'sjis')
	r.target_year = anArray[5]
	r.target_month = anArray[6]
	r.comment = anArray[7].to_s.encode('utf-8', 'sjis')
	r.created_at = anArray[8]
	r.updated_at = anArray[9]
	r.request_questionnaire_id = anArray[10]
	r.questionnaire_id = anArray[11]
	r.picture = anArray[12]
    return r    	
  end
  
end