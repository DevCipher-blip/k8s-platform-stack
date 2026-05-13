# frozen_string_literal: true

module Api
  module V1
    module Auth
      class BaseController < Api::V1::BaseController
        include Pundit::Authorization

        before_action :authorize_user!, except: %i(index create)

        def index
          authorize model

          super
        end

        def create
          authorize model

          super
        end

        private

          def authorize_user!
            raise Pundit::NotAuthorizedError unless authorized?
          end

          def authorized?
            "#{model}Policy".constantize.new(current_user, record).send("#{action_name}?")
          end
      end
    end
  end
end
