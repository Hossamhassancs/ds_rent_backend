# app/serializers/car_serializer.rb
class CarSerializer < ActiveModel::Serializer
  attributes :id, :name_en, :name_ar, :seats_num, :make_year, :engine_size, :transmission_ar, :transmission_en, :cylinders, :fuel_type_en, :fuel_type_ar, :doors, :colors, :features, :car_type_ar, :car_type_en, :brand_id, :price

  belongs_to :brand
  has_many :images
end
