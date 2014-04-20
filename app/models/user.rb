class User < ActiveRecord::Base
	
 	attr_accessor :password
	before_save :encrypt_password
	before_update :encrypt_password
	before_create {generate_token(:user_auth_token)}
	email_regex = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
	
		
	validates :password,:confirmation=> {:message=>"Password should not be blank"},:presence=>true,:length=>{:minimum=>6}
	validates :name,:presence=>true,:length=>{:within=>(2..20),:too_short=>"Please enter a bigger name",:too_long=>"Please enter a shorter name"}
	validates :email,:presence=>{:message=>"Password should not be blank"},:uniqueness=>{:case_sensitive=>false},:format=>{:with=>email_regex,:message=>"Please enter a valid email"}
	

def save_ip_address

	self.update_columns(:ip_address=>request.remote_ip)

end


def create_password_token
	self.update_columns(:password_reset_token=>SecureRandom.urlsafe_base64,:password_reset_sent_at=>Time.zone.now)
	UserMailer.password_reset(self).deliver
end

def self.authenticate(email,password)
	user=User.find_by(:email=>email)
	if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
		user
	else
		nil
	end
end

def generate_token(column)
	self[column]=SecureRandom.urlsafe_base64
end 

private
def encrypt_password
	if password.present? 
		self.password_salt=BCrypt::Engine.generate_salt
		self.password_hash=BCrypt::Engine.hash_secret(password,password_salt)
	end
end

end
