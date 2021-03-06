class InviteController < ApplicationController
	skip_before_action :verify_authenticity_token

	def new
	end

  def create
    recipient_github = GithubService.new.get_user(current_user.token, params[:github_handle])
		recipient = GithubUser.new(recipient_github)
    invitation = EmailInvitation.new(current_user.first_name, recipient)

    if invitation.email
      InvitationNotifierMailer.inform(invitation).deliver_now
      flash[:notice] = 'Successfully sent invite!'
    else
      flash[:notice] = 'The Github user you selected does not have an email address associated with their account.'
    end
    redirect_to dashboard_path
  end
end
