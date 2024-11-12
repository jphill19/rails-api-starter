class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscriptions_teas
  has_many :teas, through: :subscriptions_teas
end