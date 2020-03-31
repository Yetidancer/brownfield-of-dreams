class AuthorizeController < ApplicationController

	def create
		@authorize = AuthorizeGenerator.new
		user_email = email: params[:user_email]
		email_info = {user: current_user,
									new_user: params[:user_name],
									message: @authorize.message
		}

		NewUserNotifierMailer.inform(email_info, user_email).deliver_now
		flash[:notice] = "Authorization email has been sent to your address on file."
		redirect_to dashboard_path
	end
end
