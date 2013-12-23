class ResponsesController < ApplicationController
  # GET /responses
  # GET /responses.json
  def index

    if params[:page].nil?
    # 検索条件の設定
    # ページ繰り以外
      @searched = Hash.new()
      session[:searched] = @searched
	  	
	  if !params[:search].nil?
	  # 検索ボタン押下時：画面入力された条件のセッションへの保存
        params[:search].each do | key, value |
        @searched.store(key, value)
        end
	  end
	  	
	else
	  # ページ繰り時：検索条件のセッションからの取り出し
      @searched = session[:searched]
	end
	
    if params[:request_id].nil?    
    # アンケート依頼に対する回答一覧以外（通常はこちら）
	  @responses = Response.all
      if current_user.isAuthor?
        @searched.store('user_id', current_user.id)
	  end
    else
	# アンケート依頼に対する回答一覧
      request = RequestQuestionnaire.find(params[:request_id])
      if request
        @responses = request.responses
      else
        @responses = Array new
      end
    end
	
	# まずはページングを指示
    @responses = Response.paginate(:page => params[:page], :per_page => 10)

	# 検索条件が指定されていれば、抽出条件としてwhere句を追加
    # ユーザーID
    if !(@searched.fetch('user_id', nil).blank?)
      @responses = @responses.where('responses.user_id = ?', @searched.fetch('user_id'))
    end
    # プロジェクト名
    if !(@searched.fetch('pj_name', nil).blank?)
      @responses = @responses.where('responses.pj_name like ?', "%" + @searched.fetch('pj_name')+ "%")
    end
    # 対象年
    if !(@searched.fetch('target_year', nil).blank?)
      @responses = @responses.where('responses.target_year = ?', @searched.fetch('target_year'))
    end
    # 対象月
    if !(@searched.fetch('target_month', nil).blank?)
      @responses = @responses.where('responses.target_month = ?', @searched.fetch('target_month'))
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @responses }
    end
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
    @response = Response.find(params[:id])
	
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
    @response = Response.find(params[:id])
  end

  # POST /responses
  # POST /responses.json
  def create
    @response = Response.new(params[:response])
    @response.request_questionnaire =  current_user.request_questionnaire
    @response.questionnaire =  current_user.request_questionnaire.questionnaire
	  current_user.request_questionnaire = nil
      current_user.save
	  
    respond_to do |format|
      if @response.save
        format.html { redirect_to @response, notice: 'Response was successfully created.' }
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
    @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
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
    @response = Response.find(params[:id])
    # 回答削除時は前のアンケートを結びつける（新たにアンケート依頼がきた時の考慮がない）
	current_user.request_questionnaire = @response.request_questionnaire
    @response.destroy
    current_user.save
	
    respond_to do |format|
      format.html { redirect_to responses_url }
      format.json { head :no_content }
    end
  end
end
