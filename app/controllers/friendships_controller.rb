# frozen_string_literal: true

# This is a class
class FriendshipsController < ApplicationController
  def new; end

  def create
    friend = User.find(params[:friend_id])
    friendship = Friendship.new(user_id: current_user.id, friend_id: friend.id)
    if friendship.save(user_id: current_user.id, friend_id: friend.id)
      flash[:notice] =
        "#{friend.first_name} has been added to your friends list!"
    end
    redirect_to dashboard_path
  end
end
