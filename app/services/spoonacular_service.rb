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
      data = JSON.parse(response.body)
      price = data['price'] || 0.0
      description = data['description'] || "Description not available"
      return { price: price, description: description }
    end
    { price: 0.0, description: "Description not available" }
  end

  private

  def parse_response(response)
    if response.success?
      return JSON.parse(response.body)['products']
    end
    []
  end
end
