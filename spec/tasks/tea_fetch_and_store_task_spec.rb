
require 'rails_helper'

RSpec.describe 'tea:fetch_and_store' do
  before(:all) do
    Rails.application.load_tasks
  end

  context 'when fetching and storing tea data' do
    before do
      VCR.use_cassette('spoonacular/tea_fetch_and_store') do
        Tea.delete_all

        Rake::Task['tea:fetch_and_store'].reenable
        Rake::Task['tea:fetch_and_store'].invoke
      end
    end

    it 'stores the correct number of tea records' do
      expect(Tea.count).to eq(10)
    end

    it "stores 'TerraVita Blueberry Banana White Tea' with correct attributes" do
      tea = Tea.find_by(title: "TerraVita Blueberry Banana White Tea, (Blueberry Banana,Loose Leaf White Tea, 4 oz, 1-Pack, Zin: 537954)")
      expect(tea.description).to eq("Description not available")
      expect(tea.temperature).to eq(85)
      expect(tea.brew_time).to eq(5)
      expect(tea.image).to eq("https://img.spoonacular.com/products/4027264-312x231.jpeg")
      expect(tea.price).to eq(44.95)
    end

    it "stores 'Twinings French Vanilla Black Chai Tea Bags' with correct attributes" do
      tea = Tea.find_by(title: "Twinings French Vanilla Black Chai Tea Bags, 20 Count (Pack of 6)")
      expect(tea.description).to eq("Description not available")
      expect(tea.temperature).to eq(85)
      expect(tea.brew_time).to eq(5)
      expect(tea.image).to eq("https://img.spoonacular.com/products/6978850-312x231.jpg")
      expect(tea.price).to eq(3.32)
    end

    it 'stores the last tea item with correct attributes' do
      tea = Tea.find_by(title: "BcTlyInc Hibiscus Tea Bags, Family Size, Unsweetened, 132 Tea Bags ,22 Count (Pack of 6), Specially Blended for Iced Tea, Clear & Refreshing Home Brewed Summer Picnic Beverage")
      expect(tea.description).to eq("Description not available")
      expect(tea.temperature).to eq(85)
      expect(tea.brew_time).to eq(5)
      expect(tea.image).to eq("https://img.spoonacular.com/products/7382526-312x231.jpeg")
      expect(tea.price).to eq(38.34)
    end
  end
end
