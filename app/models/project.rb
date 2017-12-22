class Project < ApplicationRecord

  belongs_to :facilitator
  has_many :students, dependent: :destroy

  accepts_nested_attributes_for :students, allow_destroy: true

  validates :name, presence: true
  validate :estimated_dates_are_valid?

  private

  def estimated_dates_are_valid?
    errors.add(:estimated_end_date, 'must be later than start date') unless dates_are_present? && estimated_end_date > estimated_start_date
  end

  def dates_are_present?
    estimated_start_date.present? && estimated_end_date.present?
  end

end
