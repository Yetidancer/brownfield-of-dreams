class UsersController < ApplicationController
  def show
    all_repos = GithubReposService.new.user_info
    @repos = all_repos.first(5)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
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
