class ResponseItemsController < ApplicationController
  # GET /response_items
  # GET /response_items.json
  def index
    @response_items = ResponseItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @response_items }
    end
  end

  # GET /response_items/1
  # GET /response_items/1.json
  def show
    @response_item = ResponseItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @response_item }
    end
  end

  # GET /response_items/new
  # GET /response_items/new.json
  def new
    @response_item = ResponseItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @response_item }
    end
  end

  # GET /response_items/1/edit
  def edit
    @response_item = ResponseItem.find(params[:id])
  end

  # POST /response_items
  # POST /response_items.json
  def create
    @response_item = ResponseItem.new(params[:response_item])

    respond_to do |format|
      if @response_item.save
        format.html { redirect_to @response_item, notice: 'Response item was successfully created.' }
        format.json { render json: @response_item, status: :created, location: @response_item }
      else
        format.html { render action: "new" }
        format.json { render json: @response_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /response_items/1
  # PUT /response_items/1.json
  def update
    @response_item = ResponseItem.find(params[:id])

    respond_to do |format|
      if @response_item.update_attributes(params[:response_item])
        format.html { redirect_to @response_item, notice: 'Response item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @response_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /response_items/1
  # DELETE /response_items/1.json
  def destroy
    @response_item = ResponseItem.find(params[:id])
    @response_item.destroy

    respond_to do |format|
      format.html { redirect_to response_items_url }
      format.json { head :no_content }
    end
  end
end
