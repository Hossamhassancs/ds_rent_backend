class AddPickupLocationDetailsToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :pickup_location_address, :string
    add_column :reservations, :pickup_location_latitude, :float
    add_column :reservations, :pickup_location_longitude, :float
    add_column :reservations, :pickup_location_city, :string
    add_column :reservations, :pickup_location_country, :string
  end
end
