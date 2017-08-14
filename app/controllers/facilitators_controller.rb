class FacilitatorsController < ApplicationController
  before_action :authenticate_admin

  def index
    @facilitators = Facilitator.all
  end

  def show
  end


end
