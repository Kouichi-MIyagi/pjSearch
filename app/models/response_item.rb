class ResponseItem < ActiveRecord::Base
  attr_accessible :comment, :question, :response_id, :selection_item, :selection_number
  
  belongs_to :response
  
  def self.to_csv(responses)
    # CSV.generate do |csv|
      # csv << column_names
      # responses.each do |res|
        # res.response_items.each do |item|
          # csv << item.attributes.values_at(*column_names)
        # end
      # end
    # end
	CSV.generate do |csv|
      #csv << "id,response_id,question,selection_number,selection_item,comment,created_at,updated_at,社員名,顧客名,プロジェクト名,対象年,対象月,コメント,質問,回答,コメント".parse_csv
       csv << column_names + "社員名,顧客名,プロジェクト名,対象年,対象月,コメント,質問,回答,コメント".parse_csv

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
    r.id  = anArray[0]
	r.response_id = anArray[1]
	r.question = anArray[2].to_s.encode('utf-8', 'sjis')
	r.selection_number = anArray[3]
	r.selection_item = anArray[4].to_s.encode('utf-8', 'sjis')
	r.comment = anArray[5].to_s.encode('utf-8', 'sjis')
	r.created_at = anArray[6]
	r.updated_at = anArray[7]
    return r	
  end

end
