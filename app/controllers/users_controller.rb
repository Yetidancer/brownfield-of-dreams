class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
			flash[:success] = "Logged in as #{user.first_name} #{user.last_name}"
			flash[:notice] = "This account has not yet been activated. Please check your email."
      redirect_post('/authorization')
    else
      flash[:error] = 'Username already exists'
      redirect_to "/users/new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
