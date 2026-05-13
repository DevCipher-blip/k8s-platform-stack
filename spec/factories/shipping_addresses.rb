FactoryBot.define do
  factory :shipping_address do
    address_line { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip_code }
    country_code { Faker::Address.country_code }

    association :addressable, factory: [:user, :customer]
  end
end
