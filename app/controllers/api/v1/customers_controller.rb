# frozen_string_literal: true

module Api
  module V1
    class CustomersController < Auth::BaseController
      before_action :authenticate_user!

      actions :index, :create, :show, :update, :destroy

      private

        def permitted_params
          Customers::ParamsValidators::Create.new(params).execute
        end

        def record_permitted_params
          Customers::ParamsValidators::Update.new(params).execute
        end
    end
  end
end
