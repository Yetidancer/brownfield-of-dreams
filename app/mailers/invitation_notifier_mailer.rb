# frozen_string_literal: true

# This is a class
class InvitationNotifierMailer < ApplicationMailer
  def inform(invitation)
    @invitation = invitation
    mail(
      to:
        invitation.email,
      subject:
        "#{invitation.sender} is inviting you to join Brownfield of Dreams."
      )
  end
end
