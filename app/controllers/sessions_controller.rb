class SessionsController < ApplicationController

 def new
	redirect_to root_path if cookies[:user_auth_token].present?
 end

def create
if params[:email].present? && params[:password].present?
	user=User.authenticate(params[:email],params[:password])
		if user
			if params[:remember_me]
			cookies.permanent[:user_auth_token]=user.user_auth_token
				if request.remote_ip != user.ip_address.to_i || user.ip_address.blank? 
				user.update_columns(:ip_address=>request.remote_ip) 
				end
			else
			cookies[:user_auth_token]=user.user_auth_token
			end
		redirect_to root_path
		else
			flash.now[:notice]="Wrong user password combination"
			render 'new'
		end
else 
	flash.now[:notice]="Please fill in the email/password"
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

def ip_address
	params(:users).require(request.remote_ip)
end

end
