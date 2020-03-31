class NotificationsController < ApplicationController

  def create
    @authorization = AthorizationGenerator.new
    @user_email = current_user.email
    @email_info = {user: current_user,
                  message: @authorization.message
                 }
    NewUserNotifierMailer.inform(email_info, user_email).deliver_now
    flash[:notice] = "An email has been sent to your inbox. please check it now."
    redirect_to dashboard_path
  end
end
