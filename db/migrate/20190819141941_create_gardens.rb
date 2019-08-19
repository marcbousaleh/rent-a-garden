class CreateGardens < ActiveRecord::Migration[5.2]
  def change
    create_table :gardens do |t|
      t.integer :price
      t.integer :capacity
      t.string :address
      t.references :owner, foreign_key: { to_table: :users }, index: true
      t.string :photo

      t.timestamps
    end
  end
end
