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
    @user = User.find(params[:id])
    @user.destroy
    if @user.destroy
	  redirect_to user_index_path, notice: "User deleted."	 
    end
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
		#autherのプロジェクト情報をクリア
		#User.where("role = ?", 'author').update_all(:recent_project => nil, :recent_customer => nil, 
		#    :customer_id => nil, :resident => false, :transfferred => false)
	    CSV.parse(reader,:headers => true) do |row|
	      u = User.from_csv(row)
		  if u.resident? or u.transfferred?
		  #客先常駐または出向の場合、顧客マスターを確認
            cu = Customer.where("csname = ?", u.recent_customer).first
            if cu.blank? 
		    #顧客が存在せず、顧客マスターに新規作成
	          puts u.recent_customer
			  ncu = Customer.create(:csname => u.recent_customer)
			  u.customer_id = ncu.id
            else
		    #顧客が存在する場合は、その顧客IDをセット
	          u.customer_id = cu.id
            end
		  end 

		  current_u = User.where("user_id = ?", u.user_id).first
		  if current_u.blank?
		  #新規ユーザーの場合はＣＳＶファイルの内容でｉｎｓｅｒｔ
	        u.save()
		  else
		  #既に存在するユーザーの場合は、ＣＳＶファイルの内容でupdate
		    current_u.update_attributes( :email => u.email, :recent_project => u.recent_project, :recent_customer => u.recent_customer,
			    :customer_id => u.customer_id , :resident => u.resident, :transfferred => u.transfferred)
		  end
	    end
	  end
	 redirect_to user_index_path, notice: "User updated."	 
  end
  
end