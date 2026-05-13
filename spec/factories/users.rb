FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'Passw0rd-for-tests' }
    password_confirmation { password }
    sequence(:phone) { |n| format('+1-555-01%<n>02d', n: n % 100) + n.to_s }

    factory :customer, class: 'Customer' do
      type { 'Customer' }
    end

    factory :admin, class: 'Admin' do
      type { 'Admin' }
    end
  end

  trait :customer do
    type { Customer.name }
  end

  trait :admin do
    type { Admin.name }
  end
end
