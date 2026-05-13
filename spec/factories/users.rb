FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    phone { Faker::PhoneNumber.phone_number }
  end

  trait :customer do
    type { Customer.name }
  end

  trait :admin do
    type { Admin.name }
  end
end
