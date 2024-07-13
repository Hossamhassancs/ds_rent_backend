# app/controllers/api/v1/cars_controller.rb
module Api
    module V1
      class CarsController < ApplicationController
        def index
          filters = car_params
          cars = Car.filter_by(filters)
          render json: cars, each_serializer: CarSerializer
        end

        def show
            car = Car.find(params[:id])
            render json: car, serializer: CarSerializer
        end
    
  
        private
  
        def car_params
          params.permit(:name_en, :name_ar, :seats_num, :make_year, :engine_size, :transmission_ar, :transmission_en, :cylinders, :fuel_type_en, :fuel_type_ar, :doors, :colors, :car_type_ar, :car_type_en, :brand_id)
        end
      end
    end
  end
  