class Diagnostic < ApplicationRecord
  belongs_to :student
  has_many :levels, dependent: :destroy
end
