class CreateVisitingInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :visiting_interests do |t|
      t.references :country, foreign_key: true
      t.references :traveler, foreign_key: true

      t.timestamps
    end
  end
end
