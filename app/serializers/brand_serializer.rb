# app/serializers/brand_serializer.rb
class BrandSerializer < ActiveModel::Serializer
  attributes :id, :name_ar, :name_en, :logo_url

  def logo_url
    object.logo.url if object.logo.present?
  end
end
