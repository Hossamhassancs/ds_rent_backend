ActiveAdmin.register Reservation do
  permit_params :customer_name, :email, :phone, :pickup_location, :dropoff_location, :trip_type, :time, :dropoff_time, :car_id, :status, :pickup_location_address, :pickup_location_latitude, :pickup_location_longitude, :pickup_location_city, :duration_in_hours

  member_action :confirm, method: :put do
    reservation = Reservation.find(params[:id])
    reservation.update(status: 'confirmed')
    redirect_to admin_reservation_path(reservation), notice: "Reservation confirmed and email sent."
  end

  action_item :confirm, only: :show do
    link_to 'Confirm Reservation', confirm_admin_reservation_path(resource), method: :put if resource.status != 'confirmed'
  end

  index do
    selectable_column
    id_column
    column :car
    column :customer_name
    column :email
    column :phone
    column :pickup_location
    column :dropoff_location
    column :trip_type
    column :time
    column :dropoff_time
    column :duration_in_hours
    column :status
    actions defaults: true do |reservation|
      link_to('Confirm', confirm_admin_reservation_path(reservation), method: :put) if reservation.status != 'confirmed'
    end
  end

  show do
    attributes_table do
      row :car
      row :customer_name
      row :email
      row :phone
      row :pickup_location
      row :dropoff_location
      row :trip_type
      row :time
      row :dropoff_time
      row :duration_in_hours
      row :status
      row :pickup_location_address
      row :pickup_location_latitude
      row :pickup_location_longitude
      row :pickup_location_city

      row :pickup_location_map do |reservation|
        "Latitude: #{reservation.pickup_location_latitude}, Longitude: #{reservation.pickup_location_longitude}".html_safe +
        content_tag(:div, "", id: "map", style: "width: 400px; height: 300px;")
      end
    end

    panel "Map Script" do
      script src: "https://maps.googleapis.com/maps/api/js?key=YOUR_GOOGLE_MAPS_API_KEY"
      script do
        raw <<-JS
          document.addEventListener("DOMContentLoaded", function() {
            if (document.getElementById('map')) {
              var latitude = #{resource.pickup_location_latitude};
              var longitude = #{resource.pickup_location_longitude};

              var map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: latitude, lng: longitude},
                zoom: 15
              });

              new google.maps.Marker({
                position: {lat: latitude, lng: longitude},
                map: map
              });
            }
          });
        JS
      end
    end

    active_admin_comments
  end

  filter :car
  filter :customer_name
  filter :email
  filter :phone
  filter :pickup_location
  filter :dropoff_location
  filter :trip_type
  filter :time
  filter :dropoff_time
  filter :status, as: :select, collection: Reservation::STATUSES

  form do |f|
    f.inputs do
      f.input :car
      f.input :customer_name
      f.input :email
      f.input :phone
      f.input :pickup_location
      f.input :dropoff_location
      f.input :trip_type
      f.input :time, as: :datepicker
      f.input :dropoff_time, as: :datepicker
      f.input :duration_in_hours, input_html: { disabled: true }
      f.input :status
      f.input :pickup_location_address
      f.input :pickup_location_latitude
      f.input :pickup_location_longitude
      f.input :pickup_location_city
    end
    f.actions
  end
end
