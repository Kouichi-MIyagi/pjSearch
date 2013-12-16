class MenuController < ApplicationController
 before_filter :authenticate_user!

  # def index
  # end
  
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # ユーザーのアップロード（ここじゃないような）
  def upload
    require 'csv'
	  if !params[:upload_file].blank?
	    reader = params[:upload_file].read
	    CSV.parse(reader) do |row|
	      u = User.from_csv(row)
		  current_u = User.where("user_id = ?", u.user_id).first
		  if current_u == nil
		  #ユーザーテーブルにＣＳＶファイルの内容でｉｎｓｅｒｔ
	        u.save()
		  else
		  #既に存在するユーザーの場合は、ＣＳＶファイルの内容でupdate
		    current_u.update_attributes( :email => u.email, :recent_project => u.recent_project, 
			     :recent_customer => u.recent_customer, :resident => u.resident, :transfferred => u.resident)
		  end
	    end
	  end
	 redirect_to :action => :index
  end
end
