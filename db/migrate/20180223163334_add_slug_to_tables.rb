class AddSlugToTables < ActiveRecord::Migration[5.1]
  def change
    add_column :countries, :slug, :string
    add_column :guides, :slug, :string
    add_column :travelers, :slug, :string
    add_column :users, :slug, :string
  end
end
