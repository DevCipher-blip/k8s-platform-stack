require 'rails_helper'

RSpec.describe 'Self sign-up', type: :request do
  let(:payload) do
    { user: { name: 'Ada', email: 'ada@example.com', phone: '+1-555-0100',
              password: 'Passw0rd-for-tests', password_confirmation: 'Passw0rd-for-tests' } }
  end

  it 'creates a customer' do
    post '/auth', params: payload, as: :json

    expect(response).to have_http_status(:ok)
    expect(User.find_by(email: 'ada@example.com')).to be_a(Customer)
  end

  it 'ignores a requested Admin type instead of granting admin rights' do
    post '/auth', params: payload.deep_merge(user: { type: 'Admin' }), as: :json

    expect(User.find_by(email: 'ada@example.com')).to be_a(Customer)
    expect(Admin.count).to eq(0)
  end
end
