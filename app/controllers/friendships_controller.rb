class FriendshipsController < ApplicationController
  def new
  end

  def create
    require "pry"; binding.pry
    friend = User.find(friendship_params[:friend_id])
    Friendship.new(friendship_params)
    flash[:notice] = "#{friend.first_name} has been added to your friends list!"
    redirect_to dashboard_path
  end

  private
    def friendship_params
      params.permit(:user_id, :friend_id)
    end
end
