class Fix < ActiveRecord::Migration[5.0]
  def change
  	add_column :course_subjects, :course_id, :integer
    add_column :course_subjects, :subject_id, :integer
  	add_foreign_key :course_subjects, :courses, column: :course_id
    add_foreign_key :course_subjects, :subjects, column: :subject_id
  end
end
