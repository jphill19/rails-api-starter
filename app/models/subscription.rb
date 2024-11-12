class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscriptions_teas
  has_many :teas, through: :subscriptions_teas

  validates :title, presence: true
  validates :status, presence: true, inclusion: { in: ["active", "inactive", "canceled"] }
  validates :frequency, presence: true, inclusion: { in: ["daily", "weekly", "monthly", "yearly"] }


  def price
    teas.sum(:price)
  end
end
