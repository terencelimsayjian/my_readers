class Facilitator::ProjectsController < ApplicationController

  before_action :authenticate_facilitator

  def index
    @projects = current_facilitator.projects.all
  end

  def show
    @project = Project.find(params[:id])
  end

end
