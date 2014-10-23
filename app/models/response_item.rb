class ResponseItem < ActiveRecord::Base
  
  belongs_to :response
  
  #4択未入力はエラー
  validates :selection_item, :presence => true
  
  def self.to_csv(responses)
	CSV.generate do |csv|
      csv << column_names + "社員名,顧客名,プロジェクト名,対象年,対象月,コメント,設問,回答,コメント".parse_csv

      responses.each do |res|
        res.response_items.each do |item|
          csv << [item.id, item.response_id, item.question, item.selection_number, 
		          item.selection_item, item.comment, item.created_at, item.updated_at,
		          res.user.user_name,
                  res.customer.csname,
                  res.pj_name,
                  res.target_year,
                  res.target_month,
                  res.comment,
                  item.question,
                  item.selection_item,
                  item.comment]
        end
      end
    end
  end

  # CSVアップロード
  def self.from_csv(anArray)
    r = new
	#1列目（anArray[0]）は親子区分
    r.id  = anArray[1]
	r.response_id = anArray[2]
	r.question = anArray[3].to_s.encode('utf-8', 'sjis')
	r.selection_number = anArray[4]
	r.selection_item = anArray[5].to_s.encode('utf-8', 'sjis')
	r.comment = anArray[6].to_s.encode('utf-8', 'sjis')
	r.created_at = anArray[7]
	r.updated_at = anArray[8]
    return r	
  end

end
