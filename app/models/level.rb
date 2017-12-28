class Level < ApplicationRecord
  belongs_to :diagnostic

  validates :reading_level, presence: true, numericality: true
  validates :number_of_tested_words, presence: true, numericality: true
  validates :phonics_score, presence: true, numericality: { less_than_or_equal_to: :number_of_tested_words }
  validates :fluency_score, presence: true, numericality: true
  validates :comprehension_score, presence: true, numericality: true

end
