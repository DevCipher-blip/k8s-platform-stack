# frozen_string_literal: true

module Customers
  module ParamsValidators
    class Update
      attr_accessor :params

      def initialize(params)
        @params = params
      end

      def execute
        required_and_permitted_params
      end

      private

        # Every field is optional on update; requiring all of them forced a
        # password change just to edit a phone number.
        def required_and_permitted_params
          params.require(:customer).permit(generic_params)
        end

        def generic_params
          %i(name phone password password_confirmation)
        end
    end
  end
end
