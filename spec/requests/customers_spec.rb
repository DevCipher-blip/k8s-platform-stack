require 'rails_helper'

RSpec.describe 'Customers', type: :request do
  let(:customer) { create(:customer) }
  let(:other_customer) { create(:customer) }
  let(:admin) { create(:admin) }

  it 'lists customers for admins only' do
    customer
    get '/api/v1/customers', headers: auth_headers_for(admin)
    expect(response).to have_http_status(:ok)

    get '/api/v1/customers', headers: auth_headers_for(customer)
    expect(response).to have_http_status(:forbidden)
  end

  it "forbids a customer from reading another customer's profile" do
    get "/api/v1/customers/#{other_customer.id}", headers: auth_headers_for(customer)

    expect(response).to have_http_status(:forbidden)
  end

  it 'forbids customers from creating customers' do
    post '/api/v1/customers', params: { customer: { name: 'X', email: 'x@example.com', phone: '1' } },
                              headers: auth_headers_for(customer), as: :json

    expect(response).to have_http_status(:forbidden)
  end
end

RSpec.describe 'Customers without a token', type: :request do
  it 'answers 401 on member routes instead of crashing in the policy' do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"

    expect(response).to have_http_status(:unauthorized)
  end
end
