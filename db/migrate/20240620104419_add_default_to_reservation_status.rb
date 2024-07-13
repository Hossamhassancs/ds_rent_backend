class AddDefaultToReservationStatus < ActiveRecord::Migration[7.1]
  def change
    change_column_default :reservations, :status, 'pending'
  end
end
