# frozen_string_literal: true

class Admin
  # This is a class
  class DashboardController < Admin::BaseController
    def show
      @facade = AdminDashboardFacade.new
    end
  end
end
