class CreateCountryOfferings < ActiveRecord::Migration[5.1]
  def change
    create_table :country_offerings do |t|
      t.references :guide, foreign_key: true
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end
