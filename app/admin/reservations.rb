ActiveAdmin.register Reservation do
  permit_params :customer_name, :email, :phone, :pickup_location, :dropoff_location, :trip_type, :time, :dropoff_time, :car_id, :status, :pickup_location_address, :pickup_location_latitude, :pickup_location_longitude, :pickup_location_city, :duration_in_hours, :dropoff_location_address, :dropoff_location_latitude, :dropoff_location_longitude, :dropoff_location_city

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
      row :pickup_location_address
      row :pickup_location_latitude
      row :pickup_location_longitude
      row :pickup_location_city
      row :dropoff_location
      row :dropoff_location_address
      row :dropoff_location_latitude
      row :dropoff_location_longitude
      row :dropoff_location_city
      row :trip_type
      row :time
      row :dropoff_time
      row :duration_in_hours
      row :status
      row :created_at
      row :updated_at

      row :pickup_location_map do |reservation|
        "Latitude: #{reservation.pickup_location_latitude}, Longitude: #{reservation.pickup_location_longitude}".html_safe +
        content_tag(:div, "", id: "pickup_map", style: "width: 400px; height: 300px;")
      end

      row :dropoff_location_map do |reservation|
        "Latitude: #{reservation.dropoff_location_latitude}, Longitude: #{reservation.dropoff_location_longitude}".html_safe +
        content_tag(:div, "", id: "dropoff_map", style: "width: 400px; height: 300px;")
      end
    end

    panel "Map Script" do
      script src: "https://maps.googleapis.com/maps/api/js?key=YOUR_GOOGLE_MAPS_API_KEY"
      script do
        raw <<-JS
          document.addEventListener("DOMContentLoaded", function() {
            if (document.getElementById('pickup_map')) {
              var pickupLat = #{resource.pickup_location_latitude};
              var pickupLng = #{resource.pickup_location_longitude};
              var pickupMap = new google.maps.Map(document.getElementById('pickup_map'), {
                center: {lat: pickupLat, lng: pickupLng},
                zoom: 15
              });
              new google.maps.Marker({
                position: {lat: pickupLat, lng: pickupLng},
                map: pickupMap
              });
            }

            if (document.getElementById('dropoff_map')) {
              var dropoffLat = #{resource.dropoff_location_latitude};
              var dropoffLng = #{resource.dropoff_location_longitude};
              var dropoffMap = new google.maps.Map(document.getElementById('dropoff_map'), {
                center: {lat: dropoffLat, lng: dropoffLng},
                zoom: 15
              });
              new google.maps.Marker({
                position: {lat: dropoffLat, lng: dropoffLng},
                map: dropoffMap
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
  filter :pickup_location_address
  filter :pickup_location_city
  filter :dropoff_location
  filter :dropoff_location_address
  filter :dropoff_location_city
  filter :trip_type
  filter :time
  filter :dropoff_time
  filter :duration_in_hours
  filter :status, as: :select, collection: Reservation::STATUSES

  form do |f|
    f.inputs do
      f.input :car
      f.input :customer_name
      f.input :email
      f.input :phone
      f.input :pickup_location
      f.input :pickup_location_address
      f.input :pickup_location_latitude
      f.input :pickup_location_longitude
      f.input :pickup_location_city
      f.input :dropoff_location
      f.input :dropoff_location_address
      f.input :dropoff_location_latitude
      f.input :dropoff_location_longitude
      f.input :dropoff_location_city
      f.input :trip_type
      f.input :time, as: :datepicker
      f.input :dropoff_time, as: :datepicker
      f.input :duration_in_hours, input_html: { disabled: true }
      f.input :status
    end
    f.actions
  end
end
