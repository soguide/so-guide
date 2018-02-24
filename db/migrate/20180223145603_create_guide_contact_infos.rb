class CreateGuideContactInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :guide_contact_infos do |t|
      t.string :mobile_phone
      t.integer :years_experience
      t.string :main_review
      t.string :secondary_email

      t.timestamps
    end
  end
end
