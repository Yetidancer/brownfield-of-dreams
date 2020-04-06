# frozen_string_literal: true

# This is a class
class Admin::DashboardController < Admin::BaseController
  def show
    @facade = AdminDashboardFacade.new
  end
end
