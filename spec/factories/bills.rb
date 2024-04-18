# spec/factories/bills.rb

FactoryBot.define do
  factory :bill do
    user_id { nil }
    amount { 100 }
    expense_id { nil }
    paid { false }
    pay_to { nil }
    amount_paid { nil }
  end
end
