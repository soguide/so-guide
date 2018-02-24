class AddStateToGuides < ActiveRecord::Migration[5.1]
  def change
    add_column :guides, :state, :string
  end
end
