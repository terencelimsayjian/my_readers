class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.belongs_to :project, foreign_key: true
      t.string :name, null: false
      t.string :class_name, null: false
      t.string :phone_number

      t.timestamps
    end
  end
end
