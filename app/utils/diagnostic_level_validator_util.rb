class DiagnosticLevelValidator

  def get_validation_info(diagnostic_params)
    levels = diagnostic_params[:diagnostic][:levels_attributes].values

    sorted_levels = levels.sort_by {|level| level[:reading_level] }

    reading_levels = sorted_levels.map { |level| level[:reading_level] }

    if reading_levels.first != 1
      return validation_object(false, 'Invalid starting level.')
    end

    if reading_levels.last > 11
      return validation_object(false, 'Invalid ending level.')
    end

    reading_levels.each_with_index do |value, index|
      if value != index + 1
        return validation_object(false, 'Non-consecutive levels.')
      end
    end

    words_recognised_per_level = sorted_levels.map { |level| calculate_percentage_correct(level, 2) }

    words_recognised_per_level.each_with_index do |value, index|
      if value < 0.99 && index < words_recognised_per_level.length - 1
        return validation_object(false, 'Earlier levels must exceed 99% words recognised.')
      end
    end

    validation_object(true, '')
  end

  protected

  def calculate_percentage_correct(level, precision)
    (level[:phonics_score].to_f/level[:number_of_tested_words]).round(precision)
  end

  def validation_object(validity, message)
    {
        is_valid: validity,
        message: message
    }
  end
end
