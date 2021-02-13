FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    account { Faker::Lorem.characters(number: 5) }
  end
end