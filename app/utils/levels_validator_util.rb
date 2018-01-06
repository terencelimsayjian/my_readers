class LevelsValidator

  def get_validation_info(levels)
    sorted_levels = levels.sort_by {|level| level[:reading_level].to_i }

    reading_levels = sorted_levels.map { |level| level[:reading_level].to_i }

    if first_reading_level_not_one(reading_levels)
      return validation_object(false, 'Invalid starting level.')
    end

    if last_reading_level_exceeds_eleven(reading_levels)
      return validation_object(false, 'Invalid ending level.')
    end

    reading_levels.each_with_index do |value, index|
      if reading_levels_not_incremental(index, value)
        return validation_object(false, 'Non-consecutive levels.')
      end
    end

    words_recognised_per_level = sorted_levels.map { |level| calculate_percentage_correct(level, 2) }

    words_recognised_per_level.each_with_index do |value, index|
      if earlier_levels_do_not_pass_score_threshold(index, value, words_recognised_per_level)
        return validation_object(false, 'Earlier levels must exceed 99% words recognised.')
      end
    end

    validation_object(true, '')
  end

  protected

  def calculate_percentage_correct(level, precision)
    ((level[:phonics_score].to_f)/(level[:number_of_tested_words].to_f)).round(precision)
  end

  def validation_object(validity, message)
    {
    is_valid: validity,
    message: message
    }
  end

  def earlier_levels_do_not_pass_score_threshold(index, value, words_recognised_per_level)
    value < 0.99 && index < words_recognised_per_level.length - 1
  end

  def reading_levels_not_incremental(index, value)
    value != index + 1
  end

  def last_reading_level_exceeds_eleven(reading_levels)
    reading_levels.last > 11
  end

  def first_reading_level_not_one(reading_levels)
    reading_levels.first != 1
  end
end
