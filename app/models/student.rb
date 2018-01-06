class Student < ApplicationRecord

  belongs_to :project
  has_many :diagnostics, dependent: :destroy

  validates :name, presence: true
  validates :class_name, presence: true

end
