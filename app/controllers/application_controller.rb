class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  # before_filter :configure_permitted_parameters, if: :devise_controller!
  # before_filter :checkMentenance, :if => :isAuthor?

  
  def isAuthor?
	return current_user.isAuthor?
  end
  
  def checkMentenance
	if isMendenanceMode
	  redirect_to root_url,notice:'申し訳ありません。現在メンテナンス中です'
	end
  end

  def isMendenanceMode
    return Status.find(:first).is_mentenance
  end

end