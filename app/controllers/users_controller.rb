class UsersController < ApplicationController
  def new
    @user=User.new
  end
  def create
    @user=User.new(attributes)
    if @user.save
      cookies[:user_auth_token]=@user.user_auth_token
      redirect_to root_path
    else
      flash.now.alert ="User not saved"
      render 'new'
    end
  end

private
  def attributes
    params.require(:user).permit(:name,:email,:password)
  end
end
