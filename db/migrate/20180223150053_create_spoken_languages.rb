class CreateSpokenLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :spoken_languages do |t|
      t.references :language, foreign_key: true
      t.references :guide, foreign_key: true

      t.timestamps
    end
  end
end
