class CreateInstructors < ActiveRecord::Migration[5.0]
  def change
    create_table :instructors do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :brandeis_id

      t.timestamps
    end
  end
end
