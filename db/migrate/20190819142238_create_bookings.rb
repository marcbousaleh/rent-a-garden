class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :renter, foreign_key: { to_table: :users }, index: true
      t.references :garden, foreign_key: true
      t.integer :price
      t.string :status
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
