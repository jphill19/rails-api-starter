namespace :tea do
  desc "Fetch tea data from Spoonacular API and store it in the database"
  task fetch_and_store: :environment do
    service = SpoonacularService.new
    teas = service.fetch_tea_data

    Tea.delete_all
    puts "Cleared existing tea records."

    teas.each do |tea_data|

      price = service.fetch_tea_price(tea_data['id']).round(2)

      Tea.create!(
        title: tea_data['title'],
        description: 'Description not available', 
        temperature: 85, 
        brew_time: 5, 
        image: tea_data['image'],
        price: price 
      )
      puts "Added tea: #{tea_data['title']} with price: #{price}"
    end
  end
end