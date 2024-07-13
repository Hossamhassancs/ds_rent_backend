# app/controllers/api/v1/reservations_controller.rb
module Api
    module V1
      class ReservationsController < ApplicationController
        skip_before_action :verify_authenticity_token, only: [:create]

        def create
          reservation = Reservation.new(reservation_params)
          if reservation.save
            # MailSender.send(reservation_params[:customer_name],
            #                 reservation_params[:email],
            #                 reservation_params[:phone],
            #                 reservation_params[:time],
            #                 reservation_params[:car_id])
            render json: reservation, serializer: ReservationSerializer, status: :created
          else
            render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        private
  
        def reservation_params
          params.require(:reservation).permit(:customer_name, :email, :phone, :time, :car_id)
        end
      end
    end
  end
  