# app/models/brand.rb
class Brand < ApplicationRecord
    has_many :cars, dependent: :destroy
  
    mount_uploader :logo, LogoUploader
  
    def self.ransackable_attributes(auth_object = nil)
      %w[created_at id logo name_ar name_en updated_at]
    end
  
    def self.ransackable_associations(auth_object = nil)
      %w[]
    end
  
    # Define a to_s method to return the brand name
    def to_s
      name_en
    end
  end
  