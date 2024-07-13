class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.string :customer_name
      t.string :email
      t.string :phone
      t.string :pickup_location
      t.string :dropoff_location
      t.string :trip_type
      t.datetime :pickup_time
      t.datetime :dropoff_time
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
