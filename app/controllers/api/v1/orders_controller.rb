# frozen_string_literal: true

module Api
  module V1
    class OrdersController < Auth::BaseController
      before_action :authenticate_user!
      before_action :authorize_user!, except: :create

      actions :create, :show, :destroy

      def index
        raise ActiveRecord::RecordNotFound, controller_name.camelize.singularize if relation.blank?

        render json: serialize(collection, serializer)
      end

      private

        def relation
          @relation ||= customer.orders.all
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

        def authorized?
          "#{model}Policy".constantize.new(current_user, action_name == 'index' ? relation : record)
                          .send("#{action_name}?")
        end
    end
  end
end
