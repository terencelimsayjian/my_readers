class CreateDiagnostics < ActiveRecord::Migration[5.1]
  def change
    create_table :diagnostics do |t|
      t.references :student, foreign_key: true
      t.integer :index, null: false

      t.timestamps
    end
  end
end
