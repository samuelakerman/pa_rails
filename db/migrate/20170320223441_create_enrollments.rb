class CreateEnrollments < ActiveRecord::Migration[5.0]
  def change
    create_table :enrollments do |t|
      t.belongs_to :course, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end

    add_foreign_key :enrollments, :courses, column: :course_id
    add_foreign_key :enrollments, :users, column: :user_id
  end
end
