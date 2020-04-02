class InvitationNotifierMailer < ApplicationMailer
	def inform(invitation)
		require "pry"; binding.pry
    @invitation = invitation
    mail(to: invitation.email, subject: "#{invitation.sender} is inviting you to join Brownfield of Dreams.")
  end
end
