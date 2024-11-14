require 'rails_helper'

RSpec.describe "Subscriptions API", type: :request do
  before do
    @customer = create(:customer)
    @tea1 = create(:tea, title: "Green Tea", price: 10.0)
    @tea2 = create(:tea, title: "Chamomile Tea", price: 15.0)

    @subscription1 = create(:subscription, title: "Monthly Green Tea Subscription", customer: @customer)
    @subscription2 = create(:subscription, title: "Weekly Chamomile Tea Subscription", customer: @customer)

    create(:subscriptions_tea, subscription: @subscription1, tea: @tea1)
    create(:subscriptions_tea, subscription: @subscription2, tea: @tea2)
  end

  describe "#index action" do
    context "when request is valid" do
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
          expect(subscription[:attributes]).to have_key(:teas_count)
          expect(subscription[:attributes]).to have_key(:status)
          expect(subscription[:attributes]).to have_key(:frequency)
          expect(subscription[:attributes]).to have_key(:price)
          expect(subscription[:attributes]).to have_key(:customer_id)
          
        end
      end
    end
  end

  describe "#show action" do
    context "when request is valid" do
      it "returns 200 and provides a single subscription with associated teas" do
        get "/api/v1/subscriptions/#{@subscription1.id}"

        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:id]).to eq(@subscription1.id.to_s)
        expect(json[:data][:type]).to eq("subscription")

        attributes = json[:data][:attributes]
        expect(attributes[:title]).to eq("Monthly Green Tea Subscription")
        expect(attributes[:status]).to eq("active")
        expect(attributes[:frequency]).to eq("monthly")
        expect(attributes[:price]).to eq(10.0)

        customer_data = attributes[:customer]

        expect(customer_data[:id]).to eq(@customer.id)
        expect(customer_data[:first_name]).to eq(@customer.first_name)
        expect(customer_data[:last_name]).to eq(@customer.last_name)
        expect(customer_data[:email]).to eq(@customer.email)
        expect(customer_data[:address]).to eq(@customer.address)

        teas = attributes[:teas]
        expect(teas).to be_an(Array)
        expect(teas.size).to eq(1)

        tea_data = teas.first
 
        expect(tea_data[:id]).to eq(@tea1.id)
        expect(tea_data[:title]).to eq("Green Tea")
        expect(tea_data[:price]).to eq(10.0)
        expect(tea_data[:temperature]).to eq(85)
        expect(tea_data[:brew_time]).to eq(5)
        expect(tea_data[:image]).to eq("https://example.com/sample-tea.jpg")
      end
    end

    context "when the subscription does not exist" do
      it "returns 404 and an error message" do
        invalid_id = 9999999999999999999999999999999999
        get "/api/v1/subscriptions/#{invalid_id}"
  
        expect(response.status).to eq(404)
        json = JSON.parse(response.body, symbolize_names: true)
  
        expect(json).to have_key(:message)
        expect(json).to have_key(:status)
        expect(json[:message]).to eq("Couldn't find Subscription with 'id'=#{invalid_id}")
        expect(json[:status]).to eq(404)
      end
    end
  end

  describe "#update action" do
    context "when request is valid" do
      it "returns 200 and provides the updated status" do
        expect(@subscription1.status).to eq("active")
        patch "/api/v1/subscriptions/#{@subscription1.id}", params: { subscription: { status: "inactive" } }

        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: true)
        
        expect(json[:data][:id]).to eq(@subscription1.id.to_s)
        expect(json[:data][:type]).to eq("subscription")
        expect(json[:data][:attributes][:title]).to eq("Monthly Green Tea Subscription")
        expect(json[:data][:attributes][:status]).to eq("inactive")
        expect(json[:data][:attributes][:frequency]).to eq("monthly")
        expect(json[:data][:attributes][:customer_id]).to eq(@customer.id)
        expect(json[:data][:attributes][:price]).to eq(10.0)
      end
    end
    context "when the subscription does not exist" do
      it "returns 404 and an error message" do
        invalid_id = 9999999999999999999999999999999999
        patch "/api/v1/subscriptions/#{invalid_id}", params: { subscription: { status: "inactive" } }

        expect(response.status).to eq(404)
        json = JSON.parse(response.body, symbolize_names: true)
  
        expect(json).to have_key(:message)
        expect(json).to have_key(:status)
        expect(json[:message]).to eq("Couldn't find Subscription with 'id'=#{invalid_id}")
        expect(json[:status]).to eq(404)
      end
    end
    context "when the subscription status is invalid" do
      it "returns 404 and an error message" do
        expect(@subscription1.status).to eq("active")
        patch "/api/v1/subscriptions/#{@subscription1.id}", params: { subscription: { status: "canceled" } }

        expect(response.status).to eq(404)
        json = JSON.parse(response.body, symbolize_names: true)
  
        expect(json).to have_key(:message)
        expect(json).to have_key(:status)
        expect(json[:message]).to eq("Status is not included in the list")
        expect(json[:status]).to eq(404)
      end
    end
  end
end
