require 'swagger_helper'

# These examples generate swagger/v1/swagger.yaml (rails rswag:specs:swaggerize)
# and also run as ordinary request specs.
RSpec.describe 'OMS API', type: :request do
  let(:admin) { create(:admin) }
  let(:customer_user) { create(:customer) }
  let(:token) { admin.create_new_auth_token }
  let(:'access-token') { token['access-token'] }
  let(:client) { token['client'] }
  let(:uid) { token['uid'] }

  path '/auth/sign_in' do
    post 'Sign in and receive token headers' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: { email: { type: :string }, password: { type: :string } },
        required: %w(email password)
      }

      response '200', 'signed in; access-token, client and uid are returned as headers' do
        let(:credentials) { { email: admin.email, password: 'Passw0rd-for-tests' } }
        run_test! { expect(response.headers['access-token']).to be_present }
      end

      response '401', 'bad credentials' do
        let(:credentials) { { email: admin.email, password: 'wrong' } }
        run_test!
      end
    end
  end

  path '/api/v1/products' do
    get 'List the product catalogue (public)' do
      tags 'Products'
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false, description: 'max 100'

      response '200', 'a page of products' do
        schema type: :object, properties: {
          products: { type: :array, items: { '$ref' => '#/components/schemas/product' } },
          meta: { '$ref' => '#/components/schemas/page_meta' }
        }
        before { create_list(:product, 2) }
        let(:page) { 1 }
        let(:per_page) { 25 }
        run_test!
      end
    end

    post 'Create a product (admin)' do
      tags 'Products'
      consumes 'application/json'
      security [{ access_token: [], client: [], uid: [] }]
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          product: {
            type: :object,
            properties: { title: { type: :string }, description: { type: :string }, price: { type: :number },
                          weight: { type: :number }, weight_unit: { type: :string, enum: %w(g kg lb oz) } },
            required: %w(title description price)
          }
        }
      }

      response '201', 'created' do
        schema '$ref' => '#/components/schemas/product'
        let(:product) { { product: { title: 'Kettle', description: '1.7 l', price: 39.9 } } }
        run_test!
      end

      response '403', 'signed in but not an admin' do
        let(:token) { customer_user.create_new_auth_token }
        let(:product) { { product: { title: 'Kettle', description: '1.7 l', price: 39.9 } } }
        run_test!
      end
    end
  end

  path '/api/v1/customers/{customer_id}/orders' do
    parameter name: :customer_id, in: :path, type: :integer

    get "List a customer's orders (that customer or an admin)" do
      tags 'Orders'
      produces 'application/json'
      security [{ access_token: [], client: [], uid: [] }]

      response '200', 'a page of orders with line items and shipping address' do
        let(:customer_id) { customer_user.id }
        before { create(:order, customer: customer_user) }
        run_test!
      end
    end

    post 'Place an order; unit prices come from the catalogue' do
      tags 'Orders'
      consumes 'application/json'
      security [{ access_token: [], client: [], uid: [] }]
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          order: {
            type: :object,
            properties: {
              number: { type: :integer }, date: { type: :string, format: :date },
              payment_type: { type: :string, enum: %w(cash credit_card check other) },
              line_items_attributes: {
                type: :array,
                items: { type: :object, properties: { product_id: { type: :integer },
                                                      product_quantity: { type: :integer } } }
              },
              shipping_address_attributes: {
                type: :object,
                properties: { address_line: { type: :string }, city: { type: :string }, state: { type: :string },
                              zip_code: { type: :string }, country_code: { type: :string } }
              }
            },
            required: %w(number date payment_type line_items_attributes shipping_address_attributes)
          }
        }
      }

      response '201', 'created' do
        let(:customer_id) { customer_user.id }
        let(:order) do
          { order: { number: 7001, date: '2026-11-01', payment_type: 'cash',
                     line_items_attributes: [{ product_id: create(:product).id, product_quantity: 2 }],
                     shipping_address_attributes: { address_line: '1 Main St', city: 'Springfield', state: 'IL',
                                                    zip_code: '62701', country_code: 'US' } } }
        end
        run_test!
      end
    end
  end
end
