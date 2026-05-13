# frozen_string_literal: true

module Api
  module V1
    class OrdersController < Auth::BaseController
      actions :index, :create, :show, :destroy

      private

        def relation
          @relation ||= customer.orders.includes(:customer, :shipping_address, line_items: :product)
        end

        def customer
          @customer ||= Customer.find(params[:customer_id])
        end

        def permitted_params
          Orders::ParamsValidators::Create.new(params).execute
        end

        def new_resource
          @new_resource ||= customer.orders.new(permitted_params)
        end

        def record
          @record ||= customer.orders.find(params[:id])
        end

        # Listing is authorized against the customer whose orders are listed.
        def policy_target
          action_name == 'index' ? customer : record
        end
    end
  end
end
