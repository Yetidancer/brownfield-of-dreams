class InviteController < ApplicationController

	def new
	end

  def create
    response = GithubService.get_user(current_user.token, params[:github_handle])
    invitation = EmailInvitation.new(current_user.first_name, response.params[:github_handle])

    if invitation.email
      InvitationNotifierMailer.inform(invitation).deliver_now
      flash[:notice] = 'Successfully sent invite!'
    else
      flash[:notice] = 'The Github user you selected does not have an email address associated with their account.'
    end
    redirect_to dashboard_path
  end
end
