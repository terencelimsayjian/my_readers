require Rails.root.to_s + '/app/utils/diagnostic_level_validator_util.rb'

class DiagnosticsController < ApplicationController

  before_action :authenticate_user
  before_action :prepare_student, only: [:new, :create]

  def new
    @diagnostic = @student.diagnostics.build
    3.times {@diagnostic.levels.build} # To get the first row
  end

  def create

    # all the other validations can leave to active Record
    new_validator = DiagnosticLevelValidator.new

    @diagnostic = @student.diagnostics.build(diagnostic_params)

    puts(diagnostic_params)

    if @diagnostic.save
      flash[:notice] = 'Diagnostic successfully created'

      redirect_url = admin_signed_in? ? admin_project_path(@student.project_id) : facilitator_project_path(@student.project_id)
      redirect_to redirect_url
    else
      flash[:alert] = @diagnostic.errors.full_messages.to_sentence
      render :new
    end
  end

  protected

  def diagnostic_params
    params.require(:diagnostic).permit(levels_attributes: [:id, :reading_level, :number_of_tested_words, :phonics_score, :fluency_score, :comprehension_score])
  end

  def prepare_student
    @student = Student.find(params[:id])
  end

end
