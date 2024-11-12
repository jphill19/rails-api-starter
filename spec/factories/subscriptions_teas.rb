FactoryBot.define do
  factory :subscriptions_tea do
    association :subscription
    association :tea
  end
end
