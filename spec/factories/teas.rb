FactoryBot.define do
  factory :tea do
    title { "Sample Tea" }
    description { "A nice tea" }
    temperature { 85 }
    brew_time { 5 }
    price { 10.0 }
    image { "https://example.com/sample-tea.jpg" }
  end
end
