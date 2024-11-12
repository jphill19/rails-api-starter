# spec/services/spoonacular_service_spec.rb
require 'rails_helper'

RSpec.describe SpoonacularService, type: :service do
  let(:service) { SpoonacularService.new }

  describe "#fetch_tea_data", :vcr do
    context "when the request is successful" do
      it "retrieves tea products data from Spoonacular API" do
        tea_data = service.fetch_tea_data

        expect(tea_data).to be_an(Array)
        expect(tea_data.first).to include("id", "title", "image")
      end
    end

    context "when the API key is invalid", :vcr do
      it "returns an empty array" do
        allow(Rails.application.credentials).to receive(:spoonacular).and_return(api_key: 'INVALID_API_KEY')
        tea_data = service.fetch_tea_data

        expect(tea_data).to eq([])
      end
    end
  end

  describe "#fetch_tea_price", :vcr do
    context "when the request is successful" do
      it "retrieves the price of a specific tea product" do
        tea_id = 4027264 
        price = service.fetch_tea_price(tea_id)

        expect(price).to be_a(Float)
        expect(price).to be >= 0.0
      end
    end

    context "when the tea ID does not exist" do
      it "returns 0.0 as the default price" do
        tea_id = 999999999 
        price = service.fetch_tea_price(tea_id)

        expect(price).to eq([])
      end
    end
  end
end
