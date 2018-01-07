class PhonicsScoreUtil

  def self.calculate_percentage_correct(level, precision)
    ((level[:phonics_score].to_f)/(level[:number_of_tested_words].to_f)).round(precision)
  end

end