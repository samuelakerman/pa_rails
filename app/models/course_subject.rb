class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject
  validates :course, presence: true
  validates :subject, presence: true
end
