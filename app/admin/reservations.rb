# app/admin/reservations.rb
ActiveAdmin.register Reservation do
  permit_params :customer_name, :email, :phone, :time, :car_id, :status

  member_action :sold, method: :put do
    reservation = Reservation.find(params[:id])
    reservation.update(status: 'sold')
    # ReservationMailer.confirmation_email(reservation).deliver_now
    redirect_to admin_reservation_path(reservation), notice: "Reservation confirmed and email sent."
  end



  action_item :sold, only: :show do
    link_to 'Confirm Reservation', sold_admin_reservation_path(resource), method: :put if resource.status != 'confirmed'
  end



  index do
    selectable_column
    id_column
    column :car
    column :customer_name
    column :email
    column :phone
    column :time
    column :status
    actions defaults: true do |reservation|
      (link_to 'SOLD', sold_admin_reservation_path(reservation), method: :put if reservation.status != 'confirmed')
    end
  end

  show do
    attributes_table do
      row :car
      row :customer_name
      row :email
      row :phone
      row :time
      row :status
    end
    active_admin_comments
  end

  filter :car
  filter :customer_name
  filter :email
  filter :phone
  filter :time
  filter :status, as: :select, collection: Reservation::STATUSES
end
