# frozen_string_literal: true

module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        SIGN_UP_FIELDS = %i(name email phone password password_confirmation).freeze

        # Self sign-up always creates a Customer. Accepting `type` from the
        # request let anyone register themselves as an Admin.
        def sign_up_params
          params.require(:user).require(SIGN_UP_FIELDS)

          params.require(:user).permit(SIGN_UP_FIELDS).merge(type: Customer.name)
        end
      end
    end
  end
end
