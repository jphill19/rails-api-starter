# app/services/spoonacular_service.rb
require 'faraday'
require 'json'

class SpoonacularService
  BASE_URL = 'https://api.spoonacular.com'

  def initialize
    @api_key = Rails.application.credentials.spoonacular[:api_key]
    @connection = Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def fetch_tea_data
    response = @connection.get('/food/products/search', query: 'tea', apiKey: @api_key)
    parse_response(response)
  end


  def fetch_tea_price(tea_id)
    response = @connection.get("/food/products/#{tea_id}", apiKey: @api_key)
    if response.success?
      return JSON.parse(response.body)['price'] || 0.0 
    end
    []
    end
  end

  private

  def parse_response(response)
    if response.success?
      return JSON.parse(response.body)['products']
    end
    []
  end
end
