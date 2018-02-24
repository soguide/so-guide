class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude
      t.text :best_period

      t.timestamps
    end
  end
end
