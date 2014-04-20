class PasswordResetController < ApplicationController
  def new
  end
  def create
  	user=User.find_by(:email=>params[:email])
  	user.create_password_token if user
  	redirect_to login_path
  end
  def edit
user=User.find_by(:password_reset_token=>params[:id])

  end

  def update
user=User.find_by(:password_reset_token=>params[:id])
user.update(:password=>params[:password])
redirect_to root_path
  end
end
