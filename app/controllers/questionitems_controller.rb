class QuestionitemsController < ApplicationController
  # GET /questionitems
  # GET /questionitems.json
  def index
    @questionitems = Questionitem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questionitems }
    end
  end

  # GET /questionitems/1
  # GET /questionitems/1.json
  def show
    @questionitem = Questionitem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @questionitem }
    end
  end

  # GET /questionitems/new
  # GET /questionitems/new.json
  def new
    @questionitem = Questionitem.new
      @questionitem.answer1 = 1
      @questionitem.answer2 = 2
      @questionitem.answer3 = 3
      @questionitem.answer4 = 4
	  
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @questionitem }
    end
  end

  # GET /questionitems/1/edit
  def edit
    @questionitem = Questionitem.find(params[:id])
  end

  # POST /questionitems
  # POST /questionitems.json
  def create
    @questionitem = Questionitem.new(params[:questionitem])

    respond_to do |format|
      if @questionitem.save
        format.html { redirect_to @questionitem, notice: 'Questionitem was successfully created.' }
        format.json { render json: @questionitem, status: :created, location: @questionitem }
      else
        format.html { render action: "new" }
        format.json { render json: @questionitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questionitems/1
  # PUT /questionitems/1.json
  def update
    @questionitem = Questionitem.find(params[:id])

    respond_to do |format|
      if @questionitem.update_attributes(params[:questionitem])
        format.html { redirect_to @questionitem, notice: 'Questionitem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @questionitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questionitems/1
  # DELETE /questionitems/1.json
  def destroy
    @questionitem = Questionitem.find(params[:id])
    @questionitem.destroy

    respond_to do |format|
      format.html { redirect_to questionitems_url }
      format.json { head :no_content }
    end
  end
end
