class ResponsesController < ApplicationController  
  before_filter :checkMentenance, :if => :isAuthor?
  skip_load_and_authorize_resource

  # GET /responses
  # GET /responses.json
  def index

    if request.format == Mime::CSV
	  @csvDownLoad = true
	end
  
	if @csvDownLoad || !(params[:page].nil?)
	  # CSV出力、またはページ繰り時：画面入力された条件のセッションへの保存
	  @searched = session[:searched]
	else
	  # 一覧表示、あるいは検索ボタン押下時
	  @searched = Hash.new()
      session[:searched] = @searched

	  if !params[:search].nil?
	  # 検索ボタン押下時：画面入力された条件のセッションへの保存
        params[:search].each do | key, value |
          @searched.store(key, value)
        end
	  end
	end 
	
    if params[:request_id].nil?    
    # アンケート依頼に対する回答一覧以外（通常はこちら）
	  @responses = Response.all
    else
	# アンケート依頼に対する回答一覧
      request = RequestQuestionnaire.find(params[:request_id])
      if request
        @responses = request.responses
      else
        @responses = Array new
      end
    end

	#管理者以外は自分自身のものしか見えないようにする
    if current_user.isAuthor?
      @searched.store('user_id', current_user.id)
	end

	# ページングを指示
	if @csvDownLoad
      @responses = Response.includes([:user,:customer,:response_items]).paginate(:page => params[:page], :per_page => @responses.size + 1)
    else
      @responses = Response.includes([:user,:customer]).paginate(:page => params[:page], :per_page => 10)
	end
	
	#検索条件で回答を検索
	self.searchResponse
		
    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data NKF.nkf('-sW -Lw', Response.to_csv(@responses)), :filename => "responses#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}.csv", :type => 'text/csv; charset=Shift_JIS' }
      # format.xls { send_data @responses.to_csv(col_sep: "\t") }
      format.json { render json: @responses }
    end
    
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
    self.getResponseAsUserId
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @response }
    end
  end

  # GET /responses/new
  # GET /responses/new.json
  def new
    @response = Response.new
	  @response.user_id = current_user.id
	  @response.customer_id = current_user.customer_id
	  @response.pj_name = current_user.recent_project
	  @response.request_questionnaire_id =  current_user.request_questionnaire.id
	  @response.questionnaire_id =  current_user.request_questionnaire.questionnaire_id
	  
	  @response.target_year = current_user.request_questionnaire.target_year
	  @response.target_month = current_user.request_questionnaire.target_month

      current_user.request_questionnaire.questionnaire.questionitems.each do |item|
	    responce_item = ResponseItem.new
		responce_item.question = item.question
		@response.response_items << responce_item
	  end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @response }
    end
  end

  # GET /responses/1/edit
  def edit
    self.getResponseAsUserId
  end

  # POST /responses
  # POST /responses.json
  def create
    @response = Response.new(params[:response])
    @response.request_questionnaire =  current_user.request_questionnaire
    @response.questionnaire =  current_user.request_questionnaire.questionnaire
	@response.user.request_questionnaire = nil
    
    respond_to do |format|
      if @response.save
	    @response.user.save
        #ユーザー情報の回答日を更新する
        @userState = current_user.targetUserState(@response.target_year,@response.target_month)
        if !(@userState.blank?)
          @userState.respose_date = current_user.updated_at
          @userState.save
        end

        format.html { redirect_to root_path, notice: '回答を登録しました．ありがとうございました．' }
        format.json { render json: @response, status: :created, location: @response }
      else
        format.html { render action: "new" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /responses/1
  # PUT /responses/1.json
  def update
    self.getResponseAsUserId

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to @response, notice: '回答を更新しました．' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    self.getResponseAsUserId
    # 回答削除時は現在のアンケートを結びつける
	@response.user.request_questionnaire = @response.request_questionnaire
    @response.user.save
    @response.destroy
    # ユーザー状況の回答日もクリアする
	@userState = current_user.targetUserState(@response.target_year,@response.target_month)
    if !(@userState.blank?)
      @userState.respose_date = nil
      @userState.save
    end
    respond_to do |format|
      format.html { redirect_to responses_url ,notice: '回答を削除しました.'}
      format.json { head :no_content }
    end
  end
  
  def getResponseAsUserId
    if current_user.isAuthor?
	#管理者以外は自分自身のものしか見えないようにする
	  @response = Response.where(:id => params[:id]).where(:user_id => current_user.id).first
	else
      @response = Response.find(params[:id])	
	end
  end
  
  def searchResponse
    # 検索条件が指定されていれば、抽出条件としてwhere句を追加
    # 顧客名
    if !(@searched.fetch('csname', nil).blank?)
      @responses = @responses.includes(:customer).where(Customer.arel_table[:csname].matches("%" + @searched.fetch('csname')+ "%"))
    end
    # 対象年
    if !(@searched.fetch('target_year', nil).blank?)
      @responses = @responses.where('responses.target_year = ?', @searched.fetch('target_year'))
    end
    # 対象月
    if !(@searched.fetch('target_month', nil).blank?)
      @responses = @responses.where('responses.target_month = ?', @searched.fetch('target_month'))
    end
	# ユーザーID
    if !(@searched.fetch('user_id', nil).blank?)
      @responses = @responses.where('responses.user_id = ?', @searched.fetch('user_id'))
    end
	# コメント
    #  @responses = @responses.where("comment not ?", nil)
	
	
	#検索条件をセッションに保管
	session[:searchedResponses] = @responses.to_sql

  end
  
  def deleteResponses
	#対象データの削除（本番環境データをローカルに移した後処理）
	@responses = Response.paginate(:page => params[:page], :per_page => Response.count + 1)
	@searched = session[:searched]
	
	#メンテナンス中しか一括削除できないように
	if self.isMendenanceMode
	  #検索条件で回答を検索
	  self.searchResponse
	
	  @responses.destroy_all
	
	  respond_to do |format|
        format.html { redirect_to responses_url ,notice: '回答を削除しました.'}
        format.json { head :no_content }
      end
	else
	  redirect_to responses_url, alert: 'メンテナンス状態にしてください'
	end
	
  end
  
  def upload
    if !params[:upload_file].blank?
      reader = params[:upload_file].read
	  #sqlをLog出力しないように設定
	  self.setInfoToLoglevel
	  
	  self.CsvToResponse(reader)
	  
	  #Log出力を元に戻す
	  self.backOnloglevel	  
    end
    redirect_to responses_url, notice: 'response was successfully imported.'
  end

    # CSVファイルからUser_Stateを作成
  def CsvToResponse(reader)
    require 'csv'
	ActiveRecord::Base.transaction do

	  #一括インサート用の配列作成
	  newResponses = []
	  newResponseItem = []
		  
      CSV.parse(reader,:headers => true) do |row|  
	    if row[0] == "true"
		  #Response
          newResponses << Response.from_csv(row)
		else
		  #Response_item
		  newResponseItem << ResponseItem.from_csv(row)
	    end
	  end
		
	  #ResponseとResponse_itemの一括インサート
	  Response.import newResponses
	  ResponseItem.import newResponseItem
    end

  end
  
end