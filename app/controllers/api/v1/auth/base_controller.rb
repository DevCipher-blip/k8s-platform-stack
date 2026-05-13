# frozen_string_literal: true

module Api
  module V1
    module Auth
      class BaseController < Api::V1::BaseController
        include Pundit::Authorization

        # Authentication must run before authorization, or the policies see a nil user.
        before_action :authenticate_user!
        before_action :authorize_user!, except: :create

        def create
          authorize new_resource, :create?, policy_class: policy_class

          super
        end

        private

          def authorize_user!
            authorize policy_target, "#{action_name}?", policy_class: policy_class
          end

          # Collection actions are authorized against the model class; member
          # actions against the loaded record.
          def policy_target
            action_name == 'index' ? model : record
          end

          def policy_class
            "#{model}Policy".constantize
          end
      end
    end
  end
end
