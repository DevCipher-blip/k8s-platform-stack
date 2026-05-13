require 'rails_helper'

RSpec.describe 'db/seeds.rb' do
  around do |example|
    original = ENV.to_h.slice('SEED_ADMIN_PASSWORD', 'SEED_ADMIN_EMAIL')
    ENV['SEED_ADMIN_PASSWORD'] = 'Passw0rd-for-tests'
    example.run
  ensure
    ENV.delete('SEED_ADMIN_PASSWORD')
    ENV.update(original)
  end

  it 'creates the demo catalogue and admin, and is safe to run twice' do
    2.times { load Rails.root.join('db/seeds.rb') }

    expect(Product.count).to eq(3)
    expect(Admin.pluck(:email)).to eq(['admin@example.com'])
  end
end
