class AddDescriptionToGuides < ActiveRecord::Migration[5.1]
  def change
    add_column :guides, :description, :text
  end
end
