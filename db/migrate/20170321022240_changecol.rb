class Changecol < ActiveRecord::Migration[5.0]
    def up
        change_column :course_subjects, :course_id, :string
    end

    def down
        change_column :course_subjects, :course_id, :int
    end


end
