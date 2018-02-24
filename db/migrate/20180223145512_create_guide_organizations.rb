class CreateGuideOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :guide_organizations do |t|
      t.string :name
      t.string :structure_website
      t.string :facebook_profil_url
      t.string :facebook_structure_url
      t.string :license

      t.timestamps
    end
  end
end
