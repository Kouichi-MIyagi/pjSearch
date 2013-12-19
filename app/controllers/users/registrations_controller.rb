class Users::RegistrationsController < Devise::RegistrationsController
  def cancel
    super
  end
  def create
    super
  end
  def new
    super
  end
  def edit
    super
  end
  def update
    super
  end
  def destroy
    super
  end
  
  def index
    @users = User.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def upload
    require 'csv'
	  if !params[:upload_file].blank?
	    reader = params[:upload_file].read
	    CSV.parse(reader,:headers => true) do |row|
	      u = User.from_csv(row)
		  current_u = User.where("user_id = ?", u.user_id).first
		  if current_u.blank?
		  #ユーザーテーブルにＣＳＶファイルの内容でｉｎｓｅｒｔ
	        u.save()
		  else
		  #既に存在するユーザーの場合は、ＣＳＶファイルの内容でupdate
		    current_u.update_attributes( :email => u.email, :recent_project => u.recent_project, :recent_customer => u.recent_customer,
			    :customer_id => u.customer_id , :resident => u.resident, :transfferred => u.transfferred)
		  end
	    end
	  end
	 redirect_to :action => :index
  end

end