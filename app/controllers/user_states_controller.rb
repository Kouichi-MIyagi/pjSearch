class UserStatesController < ApplicationController
  # GET /user_states
  # GET /user_states.json
  def index

    if request.format == Mime::CSV
	  @csvDownLoad = true
	  @per_page = UserState.count(:id) + 1
	else
	  @csvDownLoad = false
	  @per_page = 10
	end

    if @csvDownLoad || !(params[:page].nil?)
	# ページ繰り時：検索条件のセッションからの取り出し
      @target = session[:target]
	else
    # ページ繰り以外
      @target = Hash.new()
      session[:target] = @target
	  	
	  if !params[:target].nil?
	  # 検索ボタン押下時：画面入力された条件のセッションへの保存
        params[:target].each do | key, value |
          @target.store(key, value)
        end
	  end	  	
	end
    
	# ページングを指示	
	@user_states = UserState.includes([:user]).paginate(:page => params[:page], :per_page => @per_page).order('target_year DESC, target_month DESC, user_states.id ASC')	  

    # 検索条件が指定されていれば、抽出条件としてwhere句を追加
    # 対象年
    if !(@target.fetch('target_year', nil).blank?)
      @user_states = @user_states.where('user_states.target_year = ?', @target.fetch('target_year'))
    end
    # 対象月
    if !(@target.fetch('target_month', nil).blank?)
      @user_states = @user_states.where('user_states.target_month = ?', @target.fetch('target_month'))
    end
	# 未回答（回答依頼ありで回答がないもの）
    if !(@target.fetch('noResponse', nil).blank?)
		@user_states = @user_states.where('request_date IS NOT NULL').where(respose_date: nil)
	end
	# user_idでの検索
    if !(@target.fetch('target_user', nil).blank?)
		@user_states = @user_states.where(User.arel_table[:user_id].eq(@target.fetch('target_user')))
	end

	# if @showOverTime
	  # @user_states = @user_states.where(UserState.arel_table[:over_time].gteq(1))
	# end

    respond_to do |format|
      format.html # index.html.erb
	  format.csv { send_data NKF.nkf('-sW -Lw', UserState.to_csv(@user_states)), :filename => "UserStates#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}.csv", :type => 'text/csv; charset=Shift_JIS' }
      format.json { render json: @user_states }
    end
  end

  # GET /user_states/1
  # GET /user_states/1.json
  def show
    @user_state = UserState.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_state }
    end
  end

  # GET /user_states/new
  # GET /user_states/new.json
  def new
    @user_state = UserState.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_state }
    end
  end

  # GET /user_states/1/edit
  def edit
    @user_state = UserState.find(params[:id])
  end

  # POST /user_states
  # POST /user_states.json
  def create
    @user_state = UserState.new(params[:user_state])

    respond_to do |format|
      if @user_state.save
        format.html { redirect_to @user_state, notice: 'User state was successfully created.' }
        format.json { render json: @user_state, status: :created, location: @user_state }
      else
        format.html { render action: "new" }
        format.json { render json: @user_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_states/1
  # PUT /user_states/1.json
  def update
    @user_state = UserState.find(params[:id])

    respond_to do |format|
      if @user_state.update_attributes(params[:user_state])
        format.html { redirect_to @user_state, notice: 'User state was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_states/1
  # DELETE /user_states/1.json
  def destroy
    @user_state = UserState.find(params[:id])
    @user_state.destroy

    respond_to do |format|
      format.html { redirect_to user_states_url }
      format.json { head :no_content }
    end
  end

  def upload
    #require 'csv'
	
    @target = Hash.new()
    session[:target] = @target
    
    if !params[:target].nil?
    # アップロードボタン押下時：画面入力された年月のセッションへの保存
      params[:target].each do | key, value |
        @target.store(key, value)
      end
    end

    targetYear = @target.fetch('uploadYear')
    targetMonth = @target.fetch('uploadMonth')
    targetOvertime = params[:updateOvertime]
    
    if !params[:upload_file].blank?
      if targetOvertime.nil?
        reader = params[:upload_file].read
		CsvToUserStates(targetYear,targetMonth,reader)
      else
        #残業時間の更新
        reader = params[:upload_file].read
        CSV.parse(reader,:headers => true) do |row|
          u = UserState.from_csv(row)
          if !u.user_id.nil?
            current_u = UserState.where("user_id = ?", u.user_id)
                        .where("target_year = ?", targetYear)
                        .where("target_month = ?", targetMonth).first
            if !current_u.blank?
              #既に存在するユーザーの場合のみ、ＣＳＶファイルの内容でupdate
             current_u.update_attributes( :over_time => u.over_time ,:mc_time => u.mc_time)
            end
          end
        end
      end
      redirect_to user_states_path, notice: 'User state was successfully created.'
    end
  end
  
  # CSVファイルからUser_Stateを作成
  def CsvToUserStates(targetYear,targetMonth,reader)
    #require 'csv'
	require 'kconv'
	
	ActiveRecord::Base.transaction do
	  if !UserState.exists?(:target_year => targetYear, :target_month => targetMonth) 
		#autherの情報をクリア(同一年月のUserStateがない場合のみ)
		User.where("role = ?", 'author').update_all(:resident => false, :transfferred => false)
	  end
	  #一括インサート用の配列作成
	  newUserStates = []

	  #sqlをLog出力しないように設定
	  self.setInfoToLoglevel
	  
	  #CSVファイルの読み込み
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
		current_u = User.where("user_id = ?", u.user_id).first
		if current_u.blank?
		  #新規ユーザーの場合はＣＳＶファイルの内容でｉｎｓｅｒｔ
		  u.save()
		else
		  #既に存在するユーザーの場合は、ＣＳＶファイルの内容でupdate
		  current_u.update_attributes( :email => u.email, :recent_project => u.recent_project, :recent_customer => u.recent_customer,
		   :customer_id => u.customer_id , :resident => u.resident, :transfferred => u.transfferred, :user_name => u.user_name)
		  u.id = current_u.id
		end
		newUserStates << UserState.new(csname: u.recent_customer, resident: u.resident, transfferred:u.transfferred,
		  user_id: u.id, customer_id:u.customer_id, target_year: targetYear, target_month: targetMonth)
	  end
	  #UserStateの一括インサート
	  UserState.import newUserStates
	  
	  #Log出力を元に戻す
	  self.backOnloglevel	  

	end
  end

end
