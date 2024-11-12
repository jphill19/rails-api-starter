class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes :title, :status, :frequency, :customer_id

  attribute :price do |subscription|
    subscription.price.to_f.round(2)
  end

  has_many :teas, serializer: TeaSerializer
end
