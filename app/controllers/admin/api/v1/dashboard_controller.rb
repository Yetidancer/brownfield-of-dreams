class Admin::Api::V1::DashboardController < Admin::Api::V1::BaseController
  def show
    @facade = AdminDashboardFacade.new
  end
end
