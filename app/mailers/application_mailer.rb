# frozen_string_literal: true

# This is a class
class ApplicationMailer < ActionMailer::Base
  default from: 'admin@brownfieldofdreams.com'
  layout 'mailer'
end
