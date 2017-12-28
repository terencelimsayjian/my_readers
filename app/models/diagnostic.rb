class Diagnostic < ApplicationRecord
  belongs_to :student
  has_many :levels, dependent: :destroy
  accepts_nested_attributes_for :levels
end
