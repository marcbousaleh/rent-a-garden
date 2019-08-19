class AddDescriptionToGardens < ActiveRecord::Migration[5.2]
  def change
    add_column :gardens, :description, :text
  end
end
