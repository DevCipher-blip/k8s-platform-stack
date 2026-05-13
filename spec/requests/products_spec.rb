require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:admin) { create(:admin) }
  let(:customer) { create(:customer) }
  let(:payload) { { product: { title: 'Kettle', description: 'Steel, 1.7 l', price: 39.9 } } }

  it 'serves the catalogue without authentication' do
    create(:product)

    get '/api/v1/products'

    expect(response).to have_http_status(:ok)
    expect(json['products'].size).to eq(1)
  end

  it 'lets admins create products' do
    post '/api/v1/products', params: payload, headers: auth_headers_for(admin), as: :json

    expect(response).to have_http_status(:created)
  end

  it 'forbids customers from creating products' do
    post '/api/v1/products', params: payload, headers: auth_headers_for(customer), as: :json

    expect(response).to have_http_status(:forbidden)
  end
end
