class Student < ApplicationRecord
  default_scope { order({name: :asc}, {class_name: :asc}) }

  belongs_to :project
  has_many :diagnostics, dependent: :destroy

  validates :name, presence: true
  validates :class_name, presence: true

end
