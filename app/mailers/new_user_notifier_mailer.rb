class NewUserNotifierMailer < ApplicationMailer
	def inform(email_info)
		@email_info = email_info
		mail(to: "#{@email_info[:user].email}", subject: "#{@email_info[:user].first_name}, Please Authenticate your account.")
	end
end
