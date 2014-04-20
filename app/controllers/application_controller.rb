class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
helper_method :current_user

  private

  def current_user
  	if cookies[:user_auth_token]
  	@current_user||=User.find_by(:user_auth_token =>cookies[:user_auth_token]) 
  	else 
  	redirect_to login_path
  end
  end
end
