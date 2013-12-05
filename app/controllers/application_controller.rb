class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  # before_filter :configure_permitted_parameters, if: :devise_controller!

end