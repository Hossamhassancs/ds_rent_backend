# app/models/car.rb
class Car < ApplicationRecord
  belongs_to :brand
  has_many :images, dependent: :destroy
  has_many :reservations, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name_en, :name_ar, :seats_num, :make_year, :engine_size, :transmission_ar, :transmission_en, :cylinders, :fuel_type_en, :fuel_type_ar, :doors, :colors, :car_type_ar, :car_type_en, presence: true
  validates :make_year, inclusion: { in: 2000..Date.current.year }
  validates :cylinders, inclusion: { in: 1..10 }
  validates :transmission_en, inclusion: { in: %w[automatic manual] }
  validates :transmission_ar, inclusion: { in: %w[مانيوال اوتوماتيك] }
  validates :price, numericality: { greater_than_or_equal_to: 0 }


  scope :filter_by, -> (filters) {
    filters.to_h.reduce(self) do |scope, (key, value)|
      value.present? ? scope.where(key => value) : scope
    end
  }

  def self.ransackable_attributes(auth_object = nil)
    %w[name_en name_ar seats_num make_year engine_size transmission_ar transmission_en cylinders fuel_type_en fuel_type_ar doors colors features car_type_ar car_type_en price in_stock]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[brand images reservations]
  end

  # Define a to_s method to return the car name
  def to_s
    "#{name_en} (#{make_year})"
  end

  # Convert the features string to an array before saving
  before_save :convert_features_to_array

  private

  def convert_features_to_array
    self.features = self.features.split(',').map(&:strip) if self.features.is_a?(String)
  end
end
