class CourseSubject2 < ActiveRecord::Migration[5.0]
  def change
  	add_foreign_key :course_subjects, :courses, column: :course_id
    add_foreign_key :course_subjects, :subjects, column: :subject_id
  end
end
