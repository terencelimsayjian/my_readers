def construct_diagnostic(student_id, index, num_passing_levels)
  diagnostic = Diagnostic.find_or_create_by(
      student_id: student_id,
      index: index,
  )

  num_passing_levels.times { |i|
    reading_level = i + 1;
    construct_level(diagnostic.id, reading_level, true)
  }

  if num_passing_levels < 11
    construct_level(diagnostic.id, num_passing_levels + 1, false)
  end
end

def construct_level(diagnostic_id, reading_level, is_pass)
  phonics_score = is_pass ? 99 : 67

  Level.find_or_create_by(
      diagnostic_id: diagnostic_id,
      reading_level: reading_level,
      number_of_tested_words: 100,
      phonics_score: phonics_score,
      fluency_score: 30,
      comprehension_score: 3,
  )
end
