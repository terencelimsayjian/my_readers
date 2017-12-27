class Admin::FacilitatorsController < ApplicationController

  before_action :authenticate_admin

  def index
    @facilitators = Facilitator.all.order(:state, :full_name)
  end

  def show; end

end
