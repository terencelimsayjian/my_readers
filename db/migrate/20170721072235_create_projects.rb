class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.belongs_to :facilitator, index: true

      t.timestamps
    end
  end
end
