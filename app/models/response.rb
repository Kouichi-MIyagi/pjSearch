class Response < ActiveRecord::Base
  attr_accessible :comment, :customer_id, :pj_name, :target_month, :target_year, :user_id, :request_questionnaire_id, :questionnaire_id
  
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
      # csv << column_names
      csv << "社員名,顧客名,プロジェクト名,対象年,対象月,コメント,質問,回答,コメント".parse_csv

      #  csv << response.attributes.values_at(*column_names)
      # all.each do |response|
      responses.each do |response|
        response.response_items.each do |response_item|
          csv << [response.user.user_name,
                  response.customer.csname,
                  response.pj_name,
                  response.target_year,
                  response.target_month,
                  response.comment,
                  response_item.question,
                  response_item.selection_item,
                  response_item.comment]
        end
      end
    end
  end

end