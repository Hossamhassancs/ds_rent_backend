# app/controllers/api/v1/brands_controller.rb
module Api
    module V1
      class BrandsController < ApplicationController
        def index
          brands = Brand.all
          render json: brands, each_serializer: BrandSerializer
        end
      end
    end
  end
  