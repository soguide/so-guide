class CreateCountryPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :country_photos do |t|
      t.references :country, foreign_key: true
      t.string :main
      t.string :second
      t.string :third
      t.string :fourth

      t.timestamps
    end
  end
end
