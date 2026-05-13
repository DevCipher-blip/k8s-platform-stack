# frozen_string_literal: true

module Orders
  module ParamsValidators
    class Create
      attr_accessor :params

      def initialize(params)
        @params = params
      end

      def execute
        required_and_permitted_params
      end

      private

        def required_and_permitted_params
          required_params

          params_to_permit = generic_params.push({ line_items_attributes: generic_line_items_params })
                                           .push({ shipping_address_attributes: generic_shipping_address_params })
                                           .flatten

          params.require(:order).permit(params_to_permit)
        end

        def required_params
          params.require(:order).tap do |order_params|
            order_params.require(generic_params)
            order_params.require(:line_items_attributes).each do |line_item_attributes|
              line_item_attributes.require(generic_line_items_params)
            end
            order_params.require(:shipping_address_attributes).require(generic_shipping_address_params)
          end
        end

        def generic_params
          %i(number date payment_type)
        end

        def generic_line_items_params
          %i(product_id product_quantity product_price)
        end

        def generic_shipping_address_params
          %i(address_line city state zip_code country_code)
        end
    end
  end
end
