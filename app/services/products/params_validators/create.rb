# frozen_string_literal: true

module Products
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

          params.require(:product).permit(generic_required_params.push(generic_optional_params).flatten)
        end

        def required_params
          params.require(:product).tap do |product_params|
            product_params.require(generic_required_params)
          end
        end

        def generic_required_params
          %i(title description price)
        end

        def generic_optional_params
          %i(weight weight_unit)
        end
    end
  end
end
