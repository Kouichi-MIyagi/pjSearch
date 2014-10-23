class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  # before_filter :configure_permitted_parameters, if: :devise_controller!
  # before_filter :checkMentenance, :if => :isAuthor?

  load_and_authorize_resource

  before_action :configure_permitted_parameters, if: :devise_controller?

  
  def isAuthor?
	return current_user.isAuthor?
  end
  
  def checkMentenance
	if isMendenanceMode
	  redirect_to root_url,notice:'申し訳ありません。現在メンテナンス中です'
	end
  end

  def isMendenanceMode
    return Status.first.is_mentenance
  end

  def after_sign_in_path_for(resource)
    return current_user.requested? ? new_response_path : root_path
  end
  
  def setInfoToLoglevel
    @old_logger = Rails.logger.level
	unless Rails.env.production?
	  #production環境以外でログレベルをINFOに変更
	  Rails.logger.level = Logger::INFO
	end
  end

  def backOnloglevel
	Rails.logger.level = @old_logger
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_id
  end

end