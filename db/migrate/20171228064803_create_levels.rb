class CreateLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :levels do |t|
      t.integer :reading_level
      t.integer :number_of_tested_words
      t.integer :phonics_score
      t.integer :fluency_score
      t.integer :comprehension_score
      t.references :diagnostic, foreign_key: true

      t.timestamps
    end
  end
end
