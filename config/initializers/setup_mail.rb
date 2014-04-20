ActionMailer::Base.smtp_settings={
	:address=>"smtp.gmail.com",
	:port=>587,
	:domain=>"localhost.localdomain",
	:user_name=>"instaprintest@gmail.com",
	:password=>"incorrect1x!",
	:authentication=>"plain",
	:enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"