# frozen_string_literal: true

module Api
  module V1
    class ProductsController < Auth::BaseController
      before_action :authenticate_user!, except: :index

      actions :create, :update, :destroy

      def index
        raise ActiveRecord::RecordNotFound, controller_name.camelize.singularize if relation.blank?

        render json: serialize(collection, serializer)
      end

      private

        def permitted_params
          Products::ParamsValidators::Create.new(params).execute
        end

        def record_permitted_params
          permitted_params
        end
    end
  end
end
