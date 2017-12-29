class DiagnosticLevelValidator

  def get_validation_info(diagnostic_params)
    levels = diagnostic_params[:diagnostic][:levels_attributes].values

    sorted_reading_levels = levels.map { |level| level[:reading_level] }.sort

    if sorted_reading_levels.first != 1
      return validation_object(false, 'Invalid starting level.')
    end

    sorted_reading_levels.each_with_index do |value, index|
      if value != index + 1
        return validation_object(false, 'Non-consecutive levels.')
      end
    end

    if sorted_reading_levels.last > 11
      return validation_object(false, 'Invalid ending level.')
    end

    validation_object(true, '')
  end

  protected

  def validation_object(validity, message)
    {
        is_valid: validity,
        message: message
    }
  end

end