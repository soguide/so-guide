class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.datetime :fake_date
      t.text :content

      t.timestamps
    end
  end
end
