require 'rails_helper'

RSpec.describe SubscriptionsTea, type: :model do
  it { should belong_to(:subscription) }
  it { should belong_to(:tea) }

  it { should validate_presence_of(:subscription_id) }
  it { should validate_presence_of(:tea_id) }
end
