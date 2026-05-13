# frozen_string_literal: true

module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        def sign_up_params
          params.require(:user).require(%i(name email phone password password_confirmation type))

          params.require(:user).permit(%i(name email phone password password_confirmation type))
        end
      end
    end
  end
end
