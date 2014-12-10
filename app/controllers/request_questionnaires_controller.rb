class RequestQuestionnairesController < ApplicationController
  # GET /request_questionnaires
  # GET /request_questionnaires.json
  def index
    @request_questionnaires = RequestQuestionnaire.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @request_questionnaires }
    end
  end

  # GET /request_questionnaires/1
  # GET /request_questionnaires/1.json
  def show
    @request_questionnaire = RequestQuestionnaire.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request_questionnaire }
    end
  end

  # GET /request_questionnaires/new
  # GET /request_questionnaires/new.json
  def new
    @request_questionnaire = RequestQuestionnaire.new
    @questionnaires = Questionnaire.all()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request_questionnaire }
    end
  end

  # GET /request_questionnaires/1/edit
  def edit
    @request_questionnaire = RequestQuestionnaire.find(params[:id])
    @questionnaires = Questionnaire.all()
  end

  # POST /request_questionnaires
  # POST /request_questionnaires.json
  def create
    @request_questionnaire = RequestQuestionnaire.new(request_questionnaire_params)
    self.requestToTargetUsers
    
    respond_to do |format|
      if @request_questionnaire.save
        format.html { redirect_to @request_questionnaire, notice: 'Request questionnaire was successfully created.' }
        format.json { render json: @request_questionnaire, status: :created, location: @request_questionnaire }
      else
        format.html { render action: "new" }
        format.json { render json: @request_questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /request_questionnaires/1
  # PUT /request_questionnaires/1.json
  def update
    @request_questionnaire = RequestQuestionnaire.find(params[:id])        
    self.requestToTargetUsers
    
    respond_to do |format|
      if @request_questionnaire.update_attributes(request_questionnaire_params)
        format.html { redirect_to @request_questionnaire, notice: 'Request questionnaire was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @request_questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_questionnaires/1
  # DELETE /request_questionnaires/1.json
  def destroy
    @request_questionnaire = RequestQuestionnaire.find(params[:id])
	User.where("request_questionnaire_id = ?", @request_questionnaire.id).update_all(:request_questionnaire_id => nil)
	
    @request_questionnaire.destroy

    respond_to do |format|
      format.html { redirect_to request_questionnaires_url }
      format.json { head :no_content }
    end
  end
  
  # PUT /request_questionnaires/sendRequestMail
  # 依頼メールを送信する。
  def sendRequestMail
    @request_questionnaire = RequestQuestionnaire.find(params[:id])
    @request_questionnaire.day_of_mail_sent = Date.today
    @request_questionnaire.save
    
    RequestMailer.sendRequestMail(@request_questionnaire, @request_questionnaire.collectMailAddrs).deliver
    #render :text => "Request mail sent!  bcc are : " + @request_questionnaire.collectMailAddrs

  end

  # 画面で指示された対象のユーザを抽出する
  def extractTargetUsers
    users_r = User.all
    users_t = users_r.dup
    
    # 常駐か否かの観点で絞り込み
    if !(@request_questionnaire.resident.blank?)
      users_r = User.where('users.resident = ?', @request_questionnaire.resident)
    end

    # 出向か否かの観点で絞り込み
    if !(@request_questionnaire.transfferred.blank?)
      users_t = User.where('users.transfferred = ?', @request_questionnaire.transfferred)
    end
    
    # 常駐と出向のアンド条件
    requested = (users_r & users_t)
    
    # 対象者の中からシステム管理者を除く
    requested.delete_if {| user | user.isAdmin? }
    
    return requested
  end
  
  # 対象ユーザを判別し、対象となったユーザにリクエストをセットすると同時に、対象外のユーザはリセットする
  def requestToTargetUsers
    
    ActiveRecord::Base.transaction do
      User.update_all :request_questionnaire_id => nil
      self.extractTargetUsers.each do |user|
        #ユーザーのアンケート依頼番号とユーザー情報のアンケート依頼日を更新する
        userState = user.targetUserState(@request_questionnaire.target_year,@request_questionnaire.target_month)
        if !(userState.blank?)
          user.request_questionnaire = @request_questionnaire
          user.save
          userState.request_date = Time.now
          userState.save
        end   
      end
    end
  end


  private

  def request_questionnaire_params
    params.require(:request_questionnaire).permit(:questionnaire_id, :target_month, :target_year, :user_id, 
      :mail_tilte, :mail_banner, :mail_content, :mail_trailer, :day_of_mail_sent, :resident, :transfferred)
  end    

  
end
