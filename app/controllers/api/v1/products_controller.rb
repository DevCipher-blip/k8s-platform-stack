# frozen_string_literal: true

module Api
  module V1
    class ProductsController < Auth::BaseController
      skip_before_action :authenticate_user!, only: :index

      actions :index, :create, :update, :destroy

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
