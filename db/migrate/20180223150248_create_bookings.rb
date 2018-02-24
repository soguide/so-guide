class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :traveler, foreign_key: true
      t.references :guide, foreign_key: true
      t.datetime :start_date
      t.integer :rating
      t.datetime :end_date
      t.boolean :booked
      t.integer :price
      t.string :status

      t.timestamps
    end
  end
end
