# app/services/spoonacular_service.rb
require 'faraday'
require 'faraday_middleware'

class SpoonacularService
  BASE_URL = 'https://api.spoonacular.com'

  def initialize
    @api_key = Rails.application.credentials.spoonacular[:api_key]
    @connection = Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :url_encoded
      faraday.response :json, content_type: /\bjson$/
      faraday.adapter Faraday.default_adapter
    end
  end

  def fetch_tea_data
    response = @connection.get('/food/products/search', query: 'tea', apiKey: @api_key)
    parse_response(response)
  end

  private

  def parse_response(response)
    if response.success?
      response.body["products"]
    else
      []
    end
  end
end
