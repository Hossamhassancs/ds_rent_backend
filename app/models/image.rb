# app/models/image.rb
class Image < ApplicationRecord
  belongs_to :car
  mount_uploader :file, ImageUploader
end
