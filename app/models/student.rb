class Student < ApplicationRecord
  default_scope { order({name: :asc}, {class_name: :asc}) }

  belongs_to :project
  has_many :diagnostics, dependent: :destroy

  validates :name, presence: true
  validates :class_name, presence: true

  def current_reading_level
    latest_diagnostic = self.diagnostics.order(:created_at).last

    return 0 unless latest_diagnostic

    levels = latest_diagnostic.levels.order(:reading_level)
    getHighestReadingLevel(levels)
  end

  def beginning_reading_level
    diagnostic = self.diagnostics.order(:created_at).first

    return 0 unless diagnostic

    levels = diagnostic.levels.order(:reading_level)
    getHighestReadingLevel(levels)
  end

  private

  def getHighestReadingLevel(orderedLevels)
    scores = orderedLevels.map {|level| PhonicsScoreUtil.calculate_percentage_correct(level, 2)}

    failure_level_index = scores.index {|score| score < 0.92}

    failure_level_index ? failure_level_index : 11
  end

end
