# app/controllers/api/v1/lookup_controller.rb
module Api
    module V1
      class LookupController < ActionController::API
        def transmission_en
          transmissions = Car.distinct.pluck(:transmission_en)
          render json: transmissions
        end
  
        def fuel_type_en
          fuel_types = Car.distinct.pluck(:fuel_type_en)
          render json: fuel_types
        end
  
        def car_type_en
          car_types = Car.distinct.pluck(:car_type_en)
          render json: car_types
        end

        def years
          car_years = Car.distinct.pluck(:make_year)
          render json: car_years
        end

        def num_of_seats
          car_seats = Car.distinct.pluck(:seats_num)
          render json: car_seats
        end

        def trip_type
          trip_types = ['Pickup Airport', 'Dropoff Airport', 'Rent per Days', 'Rent per Hours']
          render json: trip_types
        end
      end
    end
  end
  