# frozen_string_literal: true

# This is a class
class ActivateController < ApplicationController
  def update
    user = User.find_by(params[:email])
    if user.active? == false
      user.update(active?: true)
      flash[:notice] = "#{user.first_name} #{user.last_name}, Thank you for Activating your account."
      redirect_to dashboard_path
    end
  end
end
