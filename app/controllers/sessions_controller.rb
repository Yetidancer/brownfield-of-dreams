# frozen_string_literal: true

# This is a class
class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def update
    user_info = request.env['omniauth.auth']
    user = User.find(current_user.id)

    user.update_attributes(
      token: user_info[:credentials][:token],
      github_username: user_info[:extra][:raw_info][:login]
    )

    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
