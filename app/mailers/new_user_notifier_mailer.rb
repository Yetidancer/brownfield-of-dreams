class NewUserNotifierMailer < ApplicationMailer
	default from: 'noreply@company.com'

  def instructions
    @name = current_user.name
    @confirmation_url = confirmation_url(current_user)

    mail to: current_user.email, subject: 'Activate your new account.'
  end
end
