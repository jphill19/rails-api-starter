class Tea < ApplicationRecord

  has_many :subscriptions_teas
  has_many :subscriptions, through: :subscriptions_teas

  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, presence: true, numericality: { only_integer: true }
  validates :brew_time, presence: true, numericality: { only_integer: true }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
