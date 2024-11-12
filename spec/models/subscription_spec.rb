require 'rails_helper'

RSpec.describe Subscription, type: :model do

  it { should belong_to(:customer) }
  it { should have_many(:subscriptions_teas) }
  it { should have_many(:teas).through(:subscriptions_teas) }


  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:status) }
  it { should validate_inclusion_of(:status).in_array(["active", "inactive"]) }
  it { should validate_presence_of(:frequency) }
  it { should validate_inclusion_of(:frequency).in_array(["daily", "weekly", "monthly", "yearly"]) }


  describe "#price" do
    it "returns the total price of all teas in the subscription" do
      subscription = create(:subscription)
      tea1 = create(:tea, price: 10.0)
      tea2 = create(:tea, price: 15.5)

      create(:subscriptions_tea, subscription: subscription, tea: tea1)
      create(:subscriptions_tea, subscription: subscription, tea: tea2)

      expect(subscription.price).to eq(25.5)
    end
  end
end
