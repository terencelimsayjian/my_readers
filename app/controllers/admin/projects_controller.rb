class Admin::ProjectsController < ApplicationController

  before_action :authenticate_admin
  before_action :prepare_facilitator, only: [:new, :create]

  def index
    @projects = Project.all
  end

  def new
    @project = @facilitator.projects.build
    @facilitator
  end

  def create
    @project = @facilitator.projects.build(project_params)
    if @project.save
      flash[:notice] = 'Project successfully created'
      redirect_to admin_facilitators_path
    else
      flash[:alert] = @project.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def prepare_facilitator
    @facilitator = Facilitator.find(params[:facilitator_id])
  end

  def project_params
    params.require(:project).permit(:name, :estimated_start_date, :estimated_end_date, students_attributes: [:id, :name, :class_name, :phone_number, :_destroy])
  end

end
