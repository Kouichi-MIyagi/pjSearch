class Users::RegistrationsController < Devise::RegistrationsController
  skip_load_and_authorize_resource

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
    if params[:format].blank?
	# プロファイルから編集画面を開いた場合
      super
    else
	# 一覧表から編集画面を開いた場合
      @user = User.find(params[:format])
    end
  end

  def update
    account_update_params = params[:user]
  
	@user = User.find(account_update_params[:id])
	
    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(account_update_params)
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(account_update_params)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
	  if current_user.isAdmin? then
	    @user = User.find(current_user.id)
	  end
      sign_in @user, :bypass => true
	  redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
	unauthorized! if cannot? :destroy, @user
    @user.destroy
    if @user.destroy
	  redirect_to user_index_path, notice: "User deleted."	 
    end
  end
  
  def index
#    @users = User.paginate(:page => params[:page], :per_page => 10).order('role DESC, user_id ASC')
	@search = User.ransack(params[:q])
    @users = @search.result.paginate(:page => params[:page], :per_page => 10).order('role DESC, user_id ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
	
    # data for google timeline chart
	gon.graph_data = @user.asTimelineRows()
    #puts gon.graph_data

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  def upload
    #require 'csv'
	require 'kconv'

	uploadUserRoll = params[:userRoll]
	
    if !params[:upload_file].blank?
      reader = params[:upload_file].read
	  CSV.parse(reader.kconv(Kconv::UTF8, Kconv::SJIS),:headers => true) do |row|
        u = User.from_csv(row)
        if u.resident? or u.transfferred?
        #客先常駐または出向の場合、顧客マスターを確認
          cu = Customer.where("csname = ?", u.recent_customer).first
          if cu.blank? 
          #顧客が存在しない場合は、顧客マスターに新規作成
            ncu = Customer.create(:csname => u.recent_customer)
            u.customer_id = ncu.id
          else
            #顧客が存在する場合は、その顧客IDをセット
            u.customer_id = cu.id
          end
        end 

		if uploadUserRoll.blank?
		  u.role = 'author'
		else
		  u.role = uploadUserRoll
		end
        current_u = User.where("user_id = ?", u.user_id).first
        if current_u.blank?
        #新規ユーザーの場合はＣＳＶファイルの内容でｉｎｓｅｒｔ
          u.save()
        else
          #既に存在するユーザーの場合は、ＣＳＶファイルの内容でupdate
          current_u.update_attributes( :email => u.email, :recent_project => u.recent_project, :recent_customer => u.recent_customer,
               :customer_id => u.customer_id , :resident => u.resident, :transfferred => u.transfferred, :role => u.role,
			   :user_name => u.user_name)
        end
      end
    end
    redirect_to user_index_path, notice: 'User was successfully created.'

  end
  
  def become
    return unless current_user.isAdmin?
    sign_in(:user, User.find(params[:id]), { :bypass => true })
    redirect_to root_url
  end
  
  private
  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
      params[:user][:password].present?
  end

  
  def user_params
    params.require(:status).permit(:email, :password, :password_confirmation, :remember_me, :user_id,
    :user_name, :customer_id,:recent_project, :recent_customer, :recent_resident, :resident, 
    :transfferred, :request_questionnaire_id, :resident_email, :role)
  end

end