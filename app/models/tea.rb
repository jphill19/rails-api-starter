class Tea < ApplicationRecord
  has_many :subscriptions_teas
  has_many :subscriptions, through: :subscriptions_teas
end