class Diagnostic < ApplicationRecord
  default_scope { order({created_at: :asc}) }

  belongs_to :student
  has_many :levels, dependent: :destroy
  accepts_nested_attributes_for :levels
end
