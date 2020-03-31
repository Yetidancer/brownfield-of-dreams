class UsersController < ApplicationController
  def show
    # @repos = GithubService.new.user_repos(current_user.token)
		# @followers = GithubService.new.user_followers(current_user.token)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
			flash[:success] = "Logged in as #{user.first_name} #{user.last_name}"
			flash[:notice] = "This account has not yet been activated. Please check your email."
      redirect_to dashboard_path
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
