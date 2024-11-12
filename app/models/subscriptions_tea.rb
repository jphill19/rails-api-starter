class SubscriptionsTea < ApplicationRecord
  belongs_to :subscription
  belongs_to :tea

  validates :subscription_id, presence: true
  validates :tea_id, presence: true
end
