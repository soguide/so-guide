class CreateGuideSpecialities < ActiveRecord::Migration[5.1]
  def change
    create_table :guide_specialities do |t|
      t.references :speciality, foreign_key: true
      t.references :guide, foreign_key: true

      t.timestamps
    end
  end
end
