module ProjectViewHelper

  class ProjectViewObject
    attr_accessor :project, :students, :labels

    def initialize(project)
      @project = project
      @students = project.students.map { |student| StudentViewObject.new(student) }
      @labels = {
          beginning_average_reading_level: get_beginning_average_reading_level(),
          current_average_reading_level: get_current_average_reading_level(),
          total_students: project.students.count,
      }
    end

    private

    def get_beginning_average_reading_level
      beginning_reading_levels = @students.map { |students| students.beginning_reading_level }
      get_average_reading_level(beginning_reading_levels)
    end

    def get_current_average_reading_level
      ending_reading_levels = @students.map { |students| students.current_reading_level }
      get_average_reading_level(ending_reading_levels)
    end

    def get_average_reading_level(reading_levels)
      totalReadingLevel = reading_levels.reduce { |acc, reading_level| acc + reading_level };
      (totalReadingLevel.to_f / reading_levels.size).round(2)
    end
  end

  class StudentViewObject
    attr_accessor :id, :name, :class_name, :phone_number, :beginning_reading_level, :current_reading_level, :num_diagnostics_taken

    def initialize(student)
      @id = student.id
      @name = student.name
      @class_name = student.class_name
      @phone_number = student.phone_number
      @beginning_reading_level = student.beginning_reading_level
      @current_reading_level = student.current_reading_level
      @num_diagnostics_taken = student.diagnostics.count
    end
  end

end

