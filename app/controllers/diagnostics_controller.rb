require Rails.root.to_s + '/app/utils/levels_validator_util.rb'

class DiagnosticsController < ApplicationController

  before_action :authenticate_user
  before_action :prepare_student, only: [:new, :create]

  def new
    @diagnostic = @student.diagnostics.build
    @diagnostic.levels.build
    @levels_information = [
        [101,102,103,104,105,106,107,108,109,110,111],
        [201,202,203,204,205,206,207,208,209,210,211],
        [301,302,303,304,305,306,307,308,309,310,311],
        [401,402,403,404,405,406,407,408,409,410,411],
    ]
  end

  def create
    diagnostic_level_validation_info = LevelsValidator.new.get_validation_info(params[:diagnostic][:levels_attributes].values)

    @diagnostic = @student.diagnostics.build(diagnostic_params)

    unless diagnostic_level_validation_info[:is_valid]
      flash[:alert] = diagnostic_level_validation_info[:message]
      render :new and return
    end


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
    params.require(:diagnostic).permit(:index, levels_attributes: [:id, :reading_level, :number_of_tested_words, :phonics_score, :fluency_score, :comprehension_score])
  end

  def prepare_student
    @student = Student.find(params[:id])
  end

end
