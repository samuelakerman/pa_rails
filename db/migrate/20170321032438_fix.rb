class Fix < ActiveRecord::Migration[5.0]
  def change
  	add_column :course_subjects, :course_id, :integer
    add_column :course_subjects, :subject_id, :integer
  	add_foreign_key :course_subjects, :courses, column: :id
    add_foreign_key :course_subjects, :subjects, column: :id
  end
end
