class PasswordResetController < ApplicationController
  
  def new
  end

  def create
    if params[:email].present?
      user=User.find_by(:email=>params[:email])
  	  user.create_password_token if user
  	  redirect_to login_path,:notice=>"Password reset instructions sent to your email id"
    else
      flash[:notice]="Please enter an email and submit"
      render 'new'
    end
  end
  
  def edit
    user=User.find_by(:password_reset_token=>params[:id])
  end

   def update
    if params[:password].present?
      user=User.find_by(:password_reset_token=>params[:id])
  
        if user.password_reset_sent_at <2.hours.ago
          if user.update(:password=>params[:password])
            redirect_to root_path,:notice=>"Password reset sucessfully"
          else
            flash[:notice]="PLease enter a valid email(Minimum length is 6 characters)"
            render 'edit'
          end
        else
            flash[:notice]="Password reset expired."
            render 'edit'
        end
    
    else
      flash[:notice]="Please enter an email"
      render 'edit'
  end
  end

end
