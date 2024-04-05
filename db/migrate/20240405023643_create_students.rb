class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name
      t.timestamps
    end

    create_table :student_images do |t|
      t.string :small_photo
      t.string :big_photo
      t.timestamps
    end

    add_reference :student_images, :student
  end
end
