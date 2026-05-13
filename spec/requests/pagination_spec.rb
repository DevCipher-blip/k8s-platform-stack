require 'rails_helper'

RSpec.describe 'Index pagination', type: :request do
  it 'returns an empty page instead of 404 when there is nothing to list' do
    get '/api/v1/products'

    expect(response).to have_http_status(:ok)
    expect(json['products']).to eq([])
    expect(json['meta']).to include('total_count' => 0, 'page' => 1)
  end

  it 'pages through results in id order' do
    products = create_list(:product, 5)

    get '/api/v1/products', params: { page: 2, per_page: 2 }

    expect(json['products'].pluck('id')).to eq(products[2..3].map(&:id))
    expect(json['meta']).to eq('page' => 2, 'per_page' => 2, 'total_count' => 5, 'total_pages' => 3)
  end

  it 'caps per_page' do
    get '/api/v1/products', params: { per_page: 10_000 }

    expect(json.dig('meta', 'per_page')).to eq(BaseCollection::MAX_PER_PAGE)
  end
end

RSpec.describe 'Order listing queries', type: :request do
  let(:customer) { create(:customer) }

  it 'lists a customer with no orders as an empty page' do
    get "/api/v1/customers/#{customer.id}/orders", headers: auth_headers_for(customer)

    expect(response).to have_http_status(:ok)
    expect(json['orders']).to eq([])
  end

  it 'serializes several orders with nested items without N+1 queries' do
    create_list(:order, 3, customer: customer)

    # Bullet raises inside the request if any association is lazily loaded per row.
    get "/api/v1/customers/#{customer.id}/orders", headers: auth_headers_for(customer)

    expect(response).to have_http_status(:ok)
    expect(json['orders'].first['line_items'].first['product']).to include('title')
  end
end
