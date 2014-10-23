class UploadedUserStatesController < ApplicationController
  # GET /uploaded_user_states
  # GET /uploaded_user_states.json
  def index
    @uploaded_user_states = UploadedUserState.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uploaded_user_states }
    end
  end

  # GET /uploaded_user_states/1
  # GET /uploaded_user_states/1.json
  def show
    @uploaded_user_state = UploadedUserState.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @uploaded_user_state }
    end
  end

  # GET /uploaded_user_states/new
  # GET /uploaded_user_states/new.json
  def new
    @uploaded_user_state = UploadedUserState.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @uploaded_user_state }
    end
  end

  # GET /uploaded_user_states/1/edit
  def edit
    @uploaded_user_state = UploadedUserState.find(params[:id])
  end

  # POST /uploaded_user_states
  # POST /uploaded_user_states.json
  def create
    @uploaded_user_state = UploadedUserState.new(uploaded_user_state_params)

    respond_to do |format|
      if @uploaded_user_state.save
        format.html { redirect_to @uploaded_user_state, notice: 'Uploaded user state was successfully created.' }
        format.json { render json: @uploaded_user_state, status: :created, location: @uploaded_user_state }
      else
        format.html { render action: "new" }
        format.json { render json: @uploaded_user_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /uploaded_user_states/1
  # PUT /uploaded_user_states/1.json
  def update
    @uploaded_user_state = UploadedUserState.find(params[:id])

    respond_to do |format|
      if @uploaded_user_state.update_attributes(uploaded_user_state_params)
        format.html { redirect_to @uploaded_user_state, notice: 'Uploaded user state was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @uploaded_user_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploaded_user_states/1
  # DELETE /uploaded_user_states/1.json
  def destroy
    @uploaded_user_state = UploadedUserState.find(params[:id])
    @uploaded_user_state.destroy

    respond_to do |format|
      format.html { redirect_to uploaded_user_states_url }
      format.json { head :no_content }
    end
  end
  
  private

  def uploaded_user_state_params
    params.require(:topic).permit(:comment, :csvfile)
  end
  
end
