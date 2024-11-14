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
      it "retrieves the price and description of a specific tea product" do
        tea_id = 4027264 
        result = service.fetch_tea_price(tea_id)

        expect(result).to be_a(Hash)
        expect(result).to have_key(:price)
        expect(result[:price]).to be_a(Float)
        expect(result[:price]).to be >= 0.0

        expect(result).to have_key(:description)
        expect(result[:description]).to be_a(String)
      end
    end

    context "when the tea ID does not exist" do
      it "returns a hash with 0.0 as the price and a default description" do
        tea_id = 999999999 
        result = service.fetch_tea_price(tea_id)

        expect(result).to be_a(Hash)
        expect(result[:price]).to eq(0.0)
        expect(result[:description]).to eq("Description not available")
      end
    end
  end
end
