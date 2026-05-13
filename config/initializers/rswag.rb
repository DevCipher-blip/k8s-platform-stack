# frozen_string_literal: true

Rswag::Api.configure do |c|
  c.openapi_root = Rails.root.join('swagger').to_s
end

Rswag::Ui.configure do |c|
  c.openapi_endpoint '/api-docs/v1/swagger.yaml', 'OMS API v1'
end
