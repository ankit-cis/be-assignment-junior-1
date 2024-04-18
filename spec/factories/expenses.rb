# spec/factories/expenses.rb

FactoryBot.define do
  factory :expense do
    amount { 100 }
    description { "Test expense" }
    created_by { "1" }
  end
end
