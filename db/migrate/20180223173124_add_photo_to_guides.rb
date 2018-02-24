class AddPhotoToGuides < ActiveRecord::Migration[5.1]
  def change
    add_column :guides, :main_photo, :string
  end
end
