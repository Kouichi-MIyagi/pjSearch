class Users::SessionsController < Devise::SessionsController
  skip_load_and_authorize_resource

  def new
    super
  end
  def create
    super
  end
 
  def destroy
    super
  end
end