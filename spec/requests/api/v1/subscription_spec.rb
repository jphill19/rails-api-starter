# spec/requests/api/v1/subscriptions_spec.rb
require 'rails_helper'

RSpec.describe "Subscriptions API", type: :request do
  describe "#index action" do
    context "when request is valid" do
      before do

        customer = create(:customer)
        tea1 = create(:tea, title: "Green Tea", price: 10.0)
        tea2 = create(:tea, title: "Chamomile Tea", price: 15.0)

        subscription1 = create(:subscription, title: "Monthly Green Tea Subscription", customer: customer)
        subscription2 = create(:subscription, title: "Weekly Chamomile Tea Subscription", customer: customer)

        create(:subscriptions_tea, subscription: subscription1, tea: tea1)
        create(:subscriptions_tea, subscription: subscription2, tea: tea2)
      end

      it "returns 200 and provides a list of subscriptions with associated teas" do
        get "/api/v1/subscriptions"

        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data]).to be_an(Array)
        expect(json[:data].size).to eq(2) 

        json[:data].each do |subscription|
          expect(subscription[:id]).not_to be_nil
          expect(subscription[:type]).to eq("subscription")
          expect(subscription[:attributes]).to have_key(:title)
          expect(subscription[:attributes]).to have_key(:status)
          expect(subscription[:attributes]).to have_key(:frequency)
          expect(subscription[:attributes]).to have_key(:price)

          expect(subscription[:relationships][:teas][:data]).to be_an(Array)
          subscription[:relationships][:teas][:data].each do |tea|
            expect(tea[:id]).not_to be_nil
            expect(tea[:type]).to eq("tea")
          end
        end
      end
    end
  end
end
