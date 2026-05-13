require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:customer) { create(:customer) }
  let(:other_customer) { create(:customer) }
  let(:admin) { create(:admin) }
  let(:product) { create(:product, price: 10) }

  def order_payload(number: 501)
    { order: { number: number, date: '2026-11-01', payment_type: 'credit_card',
               line_items_attributes: [{ product_id: product.id, product_quantity: 3 }],
               shipping_address_attributes: { address_line: '1 Main St', city: 'Springfield', state: 'IL',
                                              zip_code: '62701', country_code: 'US' } } }
  end

  describe 'POST /api/v1/customers/:customer_id/orders' do
    it 'lets a customer order for themselves' do
      post "/api/v1/customers/#{customer.id}/orders", params: order_payload, headers: auth_headers_for(customer),
                                                      as: :json

      expect(response).to have_http_status(:created)
      expect(customer.orders.count).to eq(1)
    end

    it 'prices line items from the catalogue and totals them' do
      payload = order_payload
      payload[:order][:line_items_attributes][0][:product_price] = 0.01

      post "/api/v1/customers/#{customer.id}/orders", params: payload, headers: auth_headers_for(customer), as: :json

      expect(response).to have_http_status(:created)
      expect(json['total_value']).to eq('30.0')
    end

    it 'forbids a customer from placing an order for someone else' do
      post "/api/v1/customers/#{other_customer.id}/orders", params: order_payload,
                                                            headers: auth_headers_for(customer), as: :json

      expect(response).to have_http_status(:forbidden)
      expect(Order.count).to eq(0)
    end

    it 'lets an admin place an order for a customer' do
      post "/api/v1/customers/#{customer.id}/orders", params: order_payload, headers: auth_headers_for(admin),
                                                      as: :json

      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET /api/v1/customers/:customer_id/orders' do
    before { create(:order, customer: other_customer) }

    it "forbids reading another customer's orders" do
      get "/api/v1/customers/#{other_customer.id}/orders", headers: auth_headers_for(customer)

      expect(response).to have_http_status(:forbidden)
    end

    it 'lets the owner read them' do
      get "/api/v1/customers/#{other_customer.id}/orders", headers: auth_headers_for(other_customer)

      expect(response).to have_http_status(:ok)
      expect(json['orders'].size).to eq(1)
    end
  end

  describe 'GET /api/v1/customers/:customer_id/orders/:id' do
    let(:order) { create(:order, customer: other_customer) }

    it "forbids reading another customer's order" do
      get "/api/v1/customers/#{other_customer.id}/orders/#{order.id}", headers: auth_headers_for(customer)

      expect(response).to have_http_status(:forbidden)
    end
  end

  it 'rejects unauthenticated requests' do
    get "/api/v1/customers/#{customer.id}/orders"

    expect(response).to have_http_status(:unauthorized)
  end
end
