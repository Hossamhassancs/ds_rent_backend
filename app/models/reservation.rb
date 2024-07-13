# app/models/reservation.rb
class Reservation < ApplicationRecord
  belongs_to :car

  validates :customer_name, :email, :phone, :time, presence: true
  after_initialize :set_default_status, if: :new_record?

  STATUSES = %w[pending confirmed].freeze

  validates :status, inclusion: { in: STATUSES }


  def self.ransackable_attributes(auth_object = nil)
    %w[customer_name email phone time created_at updated_at car_id status pickup_location dropoff_location trip_type]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[car]
  end

  private

  def set_default_status
    self.status ||= 'pending'
  end

end
