# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include BaseHandler
      include SerializerHandler

      def index
        raise ActiveRecord::RecordNotFound, controller_name.camelize.singularize if relation.blank?

        render json: serialize(collection, serializer)
      end

      def create
        if new_resource.save
          render json: new_resource, each_serializer: serializer, status: :created
        else
          render json: { message: new_resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: record
      end

      def update
        if record.update(record_permitted_params)
          render json: record, each_serializer: serializer
        else
          render json: { message: record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if record.destroy
          render json: record, each_serializer: serializer
        else
          render json: { message: record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      protected

        def relation
          @relation ||= model.all
        end

        def collection
          @collection ||= BaseCollection.new(relation, filter_params).results
        end

        def new_resource
          @new_resource ||= model.new(permitted_params)
        end

        def record
          @record ||= model.find(params[:id])
        end

        def permitted_params; end

        def record_permitted_params; end

        def filter_params
          params.permit
        end

        def serializer
          "#{model.name}Serializer".constantize
        end
    end
  end
end
