class CreateTravelers < ActiveRecord::Migration[5.1]
  def change
    create_table :travelers do |t|
      t.references :user, foreign_key: true
      t.string :postal
      t.string :inscription_reason
      t.string :provider
      t.string :uuid

      t.timestamps
    end
  end
end
