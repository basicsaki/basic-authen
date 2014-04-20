#require  'bcrypt'

class User < ActiveRecord::Base
	attr_accessor :password
	before_save :encrypt_password
	before_update :encrypt_password
	before_create {generate_token(:user_auth_token)}
	#	include BCrypt
	#attr_accessible :password,:name,:email
	
	validates :password,:confirmation=> true
	validates :name,:presence=>true
	validates :email,:presence=>true
	validates :password,:presence=>true 

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
