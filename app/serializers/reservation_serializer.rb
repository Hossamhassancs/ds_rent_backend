# app/serializers/reservation_serializer.rb
class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :customer_name, :email, :phone, :time, :car_id
end
