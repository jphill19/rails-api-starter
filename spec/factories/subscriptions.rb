
FactoryBot.define do
  factory :subscription do
    title { "Sample Subscription" }
    status { "active" }
    frequency { "monthly" }
    association :customer
  end
end
