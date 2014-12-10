class MenuController < ApplicationController
  skip_load_and_authorize_resource
  # def index
  # end
  
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all.order("effective_to DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  end
