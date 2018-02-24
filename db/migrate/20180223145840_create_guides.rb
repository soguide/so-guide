class CreateGuides < ActiveRecord::Migration[5.1]
  def change
    create_table :guides do |t|
      t.references :guide_organization, foreign_key: true
      t.references :guide_contact_info, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
