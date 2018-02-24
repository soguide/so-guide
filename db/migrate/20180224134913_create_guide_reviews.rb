class CreateGuideReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :guide_reviews do |t|
      t.references :guide, foreign_key: true
      t.references :review, foreign_key: true
      t.references :traveler, foreign_key: true

      t.timestamps
    end
  end
end
