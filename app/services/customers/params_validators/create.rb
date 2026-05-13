# frozen_string_literal: true

module Customers
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

          params.require(:customer).permit(generic_params)
        end

        def required_params
          params.require(:customer).tap do |customer_params|
            customer_params.require(generic_params)
          end
        end

        def generic_params
          %i(name email phone)
        end
    end
  end
end
