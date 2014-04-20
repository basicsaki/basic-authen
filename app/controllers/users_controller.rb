class UsersController < ApplicationController
 
  def new
    @user=User.new
  end

  def create
    @user=User.new(attributes)
      if @user.save
        cookies[:user_auth_token]=@user.user_auth_token
        @user.update_columns(:ip_address=>request.remote_ip) #if user.ip_address.changed? || user.ip_address.blank?
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
