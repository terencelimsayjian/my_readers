class CreateDiagnostics < ActiveRecord::Migration[5.1]
  def change
    create_table :diagnostics do |t|
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
