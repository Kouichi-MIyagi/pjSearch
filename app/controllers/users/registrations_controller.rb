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
    if params[:format].blank?
	# プロファイルから編集画面を開いた場合
      super
    else
	# 一覧表から編集画面を開いた場合
      @user = User.find(params[:format])
    end
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
    @users = User.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
	
    # data for google timeline chart
	gon.graph_data = @user.asTimelineRows()
	puts gon.graph_data #debug print
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
end