class AuthorizeController < ApplicationController

  def create
    @email_info = {user: current_user
                 }

    NewUserNotifierMailer.inform(@email_info).deliver_now
    flash[:notice] = "An email has been sent to your inbox. Please check it now."
    redirect_to '/users'
  end
end
