class AddDurationInHoursToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :duration_in_hours, :float
  end
end
