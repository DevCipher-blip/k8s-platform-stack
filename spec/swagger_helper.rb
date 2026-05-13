require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s
  config.openapi_format = :yaml

  token_header = ->(name) { { type: :apiKey, in: :header, name: name } }

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'OMS API',
        version: 'v1',
        description: 'Order management: products, customers and their orders. ' \
                     'Sign in at POST /auth/sign_in and send the returned access-token, client and uid headers.'
      },
      servers: [{ url: 'http://localhost:3000' }],
      components: {
        securitySchemes: {
          access_token: token_header.call('access-token'),
          client: token_header.call('client'),
          uid: token_header.call('uid')
        },
        schemas: {
          product: {
            type: :object,
            properties: {
              id: { type: :integer }, title: { type: :string }, description: { type: :string },
              price: { type: :string, example: '39.9' }, upc: { type: :integer },
              weight: { type: :string, nullable: true }, weight_unit: { type: :string, nullable: true }
            },
            required: %w(id title description price upc)
          },
          page_meta: {
            type: :object,
            properties: {
              page: { type: :integer }, per_page: { type: :integer },
              total_count: { type: :integer }, total_pages: { type: :integer }
            }
          },
          error: { type: :object, properties: { message: {} } }
        }
      }
    }
  }
end
