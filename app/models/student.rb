class Student < ApplicationRecord
  # has_one :student_image
  has_many :student_images
end