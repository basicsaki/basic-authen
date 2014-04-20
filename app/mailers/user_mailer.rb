class UserMailer < ActionMailer::Base
  default from: "basics.aki@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #0
  def password_reset(user)
    @user=user
    mail(:to=>@user.email,:subject=>"Hey there! Thanks for using instaprint")
#mail (:to=>@user.email,:from=>'basics.aki@gmail.com',:subject=>"Please find the password reset instructions")
  end
end
