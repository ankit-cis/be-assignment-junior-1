# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password { 'password' }
    name { 'test user' }
  end
end
