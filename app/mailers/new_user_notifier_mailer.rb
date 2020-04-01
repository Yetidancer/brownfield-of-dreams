class NewUserNotifierMailer < ApplicationMailer
	def inform(email_info, user_email)
		@email_info = email_info
		@user_email = user_email
		mail(to: "#{@email_info[:user].email}", subject: "#{@email_info[:user].first_name}, Please Authenticate your account.")
	end
end
