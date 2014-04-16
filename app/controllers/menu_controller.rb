class MenuController < ApplicationController
 before_filter :authenticate_user!

  # def index
  # end
  
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.find(:all, :order => "effective_to DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  end
