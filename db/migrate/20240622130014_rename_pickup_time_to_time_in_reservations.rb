class RenamePickupTimeToTimeInReservations < ActiveRecord::Migration[7.1]
  def change
    rename_column :reservations, :pickup_time, :time
  end
end
