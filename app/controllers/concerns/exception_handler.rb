# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |resource|
      render json: { message: I18n.t('application.exceptions.record_not_found',
                                     resource: resource.model.presence || resource) }, status: :not_found
    end

    rescue_from ActiveRecord::RecordNotUnique do |_e|
      render json: { message: I18n.t('application.exceptions.record_not_unique') }, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |e|
      missing_params = e.message.split(':').map(&:strip).drop(1).join(', ')
      render json: { message: I18n.t('application.exceptions.missing_parameter', parameters: missing_params) },
             status: :unprocessable_entity
    end

    rescue_from Pundit::NotAuthorizedError do |_e|
      render json: { message: I18n.t('application.exceptions.unauthorized') }, status: :unauthorized
    end
  end
end
