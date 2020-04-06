# frozen_string_literal: true

# This is a class
class NewUserNotifierMailer < ApplicationMailer
  def inform(email_info)
    @email_info = email_info
    mail(
      to:
        @email_info[:user].email.to_s,
      subject:
        "#{@email_info[:user].first_name}, Please Authenticate your account."
        )
  end
end
