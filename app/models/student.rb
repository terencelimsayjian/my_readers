class Student < ApplicationRecord

  belongs_to :project

  validates :name, presence: true
  validates :class_name, presence: true

end
