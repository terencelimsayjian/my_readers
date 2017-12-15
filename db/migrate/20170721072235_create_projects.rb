class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.belongs_to :facilitator, index: true
      t.string :name, null: false
      t.date :estimated_start_date, null: false
      t.date :estimated_end_date, null: false

      t.timestamps
    end
  end
end
