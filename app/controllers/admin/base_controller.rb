# frozen_string_literal: true

# This is a class
class Admin::BaseController < ApplicationController
  before_action :require_admin!

  def require_admin!
    four_oh_four unless current_user.admin?
  end
end
