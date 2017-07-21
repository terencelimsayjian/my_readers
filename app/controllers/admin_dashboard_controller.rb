class AdminDashboardController < ApplicationController
  before_action :authenticate_admin

  def facilitators
    @facilitators = Facilitator.all
  end

end
