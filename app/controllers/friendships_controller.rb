class FriendshipsController < ApplicationController
  def new
  end

  def create
    require "pry"; binding.pry
    friend = User.find_by(params[:id])
    Friendship.create(user_id: current_user.id, friend_id: friend.id)
    flash[:notice] = "#{friend.first_name} has been added to your friends list!"
    redirect_to dashboard_path
  end

  private
    def friendship_params
      params.permit(:user_id, :friend_id)
    end
end
