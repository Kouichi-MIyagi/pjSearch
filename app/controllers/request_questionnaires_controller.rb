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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request_questionnaire }
    end
  end

  # GET /request_questionnaires/1/edit
  def edit
    @request_questionnaire = RequestQuestionnaire.find(params[:id])
  end

  # POST /request_questionnaires
  # POST /request_questionnaires.json
  def create
    @request_questionnaire = RequestQuestionnaire.new(params[:request_questionnaire])

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

    respond_to do |format|
      if @request_questionnaire.update_attributes(params[:request_questionnaire])
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
    @request_questionnaire.destroy

    respond_to do |format|
      format.html { redirect_to request_questionnaires_url }
      format.json { head :no_content }
    end
  end
end
