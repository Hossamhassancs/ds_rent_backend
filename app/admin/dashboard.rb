# app/admin/dashboard.rb
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Reservations" do
          table_for Reservation.order("created_at desc").limit(10) do
            column("Car") { |reservation| reservation.car.name_en }
            column("Customer Name") { |reservation| reservation.customer_name }
            column("Phone") { |reservation| reservation.phone }
            column("Pickup Time") { |reservation| reservation.time }
            column("Status") { |reservation| status_tag(reservation.status) }
            column("Actions") { |reservation| link_to "View", admin_reservation_path(reservation) }
          end
        end
      end

      column do
        panel "Quick Actions" do
          ul do
            li link_to "Manage Reservations", admin_reservations_path
            li link_to "Manage Cars", admin_cars_path
            li link_to "Manage Brands", admin_brands_path
          end
        end
      end
    end

    columns do
      column do
        panel "Reservations Overview" do
          div do
            span do
              "Total Reservations: #{Reservation.count}"
            end
            br
            span do
              "Confirmed Reservations: #{Reservation.where(status: 'confirmed').count}"
            end
            br
            span do
              "Cancelled Reservations: #{Reservation.where(status: 'cancelled').count}"
            end
            br
            span do
              "Pending Reservations: #{Reservation.where(status: 'pending').count}"
            end
          end
        end
      end

      column do
        panel "Cars Overview" do
          div do
            span do
              "Total Cars: #{Car.count}"
            end
            br
            span do
              "Available Cars: #{Car.count}"
            end
          end
        end
      end
    end

    columns do
      column do
        panel "Recent Cars" do
          table_for Car.order("created_at desc").limit(10) do
            column("Name") { |car| car.name_en }
            column("Brand") { |car| car.brand.name_en }
            column("Seats") { |car| car.seats_num }
            column("Year") { |car| car.make_year }
            column("Transmission") { |car| car.transmission_en }
            column("Fuel Type") { |car| car.fuel_type_en }
            column("Actions") { |car| link_to "View", admin_car_path(car) }
          end
        end
      end

      column do
        panel "Brands Overview" do
          div do
            span do
              "Total Brands: #{Brand.count}"
            end
          end
        end
      end
    end
  end # content
end
