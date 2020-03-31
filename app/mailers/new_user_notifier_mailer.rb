class NewUserNotifierMailer < ApplicationMailer
	def inform(info, user_email)
		@user = info[:user]
		@message = info[:message]
		@new_user = info[:new_user]
		mail(to: user_email, subject: "Activate your new account.")
	end
end
