class AddFullNameToGuides < ActiveRecord::Migration[5.1]
  def change
    add_column :guides, :full_name, :string
  end
end
