class Users::PasswordsController < Devise::PasswordsController
  skip_load_and_authorize_resource

  def create
    super
  end
  def new
    super
  end
  def edit
    super
  end
  def update
    super
  end
end