FactoryBot.define do
  factory :customer do
    first_name { "John" }
    last_name { "Doe" }
    email { "test@example.com" }
    address { "123 Test St" }
  end
end