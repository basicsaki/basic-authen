class SessionsController < ApplicationController
	#before_filter :logged_in, :only=> [:create]

  def new
redirect_to root_path if cookies[:user_auth_token].present?
  end

def create
if params[:email].present? && params[:password].present?
	user=User.authenticate(params[:email],params[:password])
	#user=User.find(:email=>params[:email])
if user
	if params[:remember_me]
	cookies.permanent[:user_auth_token]=user.user_auth_token
else
	cookies[:user_auth_token]=user.user_auth_token
end
	redirect_to root_path
else
	render 'new'

end
else 
	#:notice="Please fill in the email/password"
	render 'new'
end

end

  def destroy
cookies.delete(:user_auth_token)
redirect_to login_path
  end

private
def logged_in
redirect_to root_path if cookies[:user_auth_token]
end



end
