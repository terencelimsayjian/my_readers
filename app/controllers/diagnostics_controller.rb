require Rails.root.to_s + '/app/utils/levels_validator_util.rb'

class DiagnosticsController < ApplicationController

  before_action :authenticate_user
  before_action :prepare_student, only: [:new, :create]

  def new
    @diagnostic = @student.diagnostics.build
    @diagnostic.levels.build
    @levels_information = [100,130,140,150,160,170,180,190,200,210,220]
  end

  def create
    diagnostic_level_validation_info = LevelsValidator.new.get_validation_info(params[:diagnostic][:levels_attributes].values)

    @diagnostic = @student.diagnostics.build(diagnostic_params)

    unless diagnostic_level_validation_info[:is_valid]
      flash[:alert] = diagnostic_level_validation_info[:message]
      render :new and return
    end

    # byebug

    if @diagnostic.save
      students = Student.where("project_id = ?", @student.project_id)
      current_student_index = students.index { |student| student.id == @student.id }

      flash[:notice] = get_flash_notice(@student, students, current_student_index)

      if params[:'submit_and_go_to_next_student'] && student_not_last_student(students, current_student_index)
        redirect_to new_student_diagnostic_path(students[current_student_index + 1].id) and return
      else
        user_project_path = admin_signed_in? ? admin_project_path(@student.project_id) : facilitator_project_path(@student.project_id)
        redirect_to user_project_path and return
      end

    else
      flash[:alert] = @diagnostic.errors.full_messages.to_sentence
      render :new
    end
  end

  protected

  def student_not_last_student(students, current_student_index)
    current_student_index + 1 != students.length
  end

  def get_flash_notice(current_student, students, current_student_index)
    flash_notice = "Diagnostic successfully created for #{current_student.name} (#{current_student.class_name})."

    if current_student_index == students.length - 1
      flash_notice << ' You have reached the end of the student list.'
    end

    flash_notice
  end

  def diagnostic_params
    params.require(:diagnostic).permit(levels_attributes: [:id, :reading_level, :number_of_tested_words, :phonics_score, :fluency_score, :comprehension_score])
  end

  def prepare_student
    @student = Student.find(params[:id])
  end

end
