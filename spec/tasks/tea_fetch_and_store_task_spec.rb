
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
      expect(tea.description).to eq("<ul>  <li>Packaged in the United States in a cGMP certified facilty (current Good Manufacturing Practice).</li>  <li>No fillers.</li>  <li>Loose Leaf White Tea - Packed in a convenient upright pouch!</li> </ul>")
      expect(tea.temperature).to eq(85)
      expect(tea.brew_time).to eq(5)
      expect(tea.image).to eq("https://img.spoonacular.com/products/4027264-312x231.jpeg")
      expect(tea.price).to eq(44.95)
    end

    it "stores 'Twinings French Vanilla Black Chai Tea Bags' with correct attributes" do
      tea = Tea.find_by(title: "Twinings French Vanilla Black Chai Tea Bags, 20 Count (Pack of 6)")
      expect(tea.description).to eq("FRESH FLAVOR: Six boxes of 20 French Vanilla Chai tea bags. Fine black tea expertly blended with spices and French vanilla flavor. Steep for four to six minutes for the perfect cup of French vanilla chai tea. <br />ONLY THE FINEST QUALITY: Our expert blenders source only the finest leaves cultivated to our exacting standards by trusted growers around the world. From these tea gardens we hand-select the leaves that will shape your next Twinings moment.Kosher <br />FRENCH VANILLA CHAI TEA: Twinings blends to perfection fine black teas with the sweet and savory spice flavors of cinnamon, cardamom, cloves and ginger to give you a line of great-tasting Chai teas with a bold taste and rich, vibrant aroma. <br />RICH HISTORY: In 1706 Thomas Twining began selling fine tea from an English storefront in The Strand, London. Today, Twinings still sells teas from the original store and in more than 100 countries throughout the world. <br />HAND SELECTED FOR YOUR HOME: Made without artificial ingredients, Twinings natural teas provide a wholesome tea experience. If you enjoy Bigelow Tea, Lipton Tea, Harney &amp; Sons Tea, Davidson's Tea, or Prince of Peace Tea - try Twinings of London Tea.")
      expect(tea.temperature).to eq(85)
      expect(tea.brew_time).to eq(5)
      expect(tea.image).to eq("https://img.spoonacular.com/products/6978850-312x231.jpg")
      expect(tea.price).to eq(3.32)
    end

    it 'stores the last tea item with correct attributes' do
      tea = Tea.find_by(title: "BcTlyInc Hibiscus Tea Bags, Family Size, Unsweetened, 132 Tea Bags ,22 Count (Pack of 6), Specially Blended for Iced Tea, Clear & Refreshing Home Brewed Summer Picnic Beverage")
      expect(tea.description).to eq( "Enjoy Summer the right way with an ice cold glass of BcTlyInc's specially blended Iced Hibiscus tea. Brewed with southern standards to keep you refreshed through the summer.")
      expect(tea.temperature).to eq(85)
      expect(tea.brew_time).to eq(5)
      expect(tea.image).to eq("https://img.spoonacular.com/products/7382526-312x231.jpeg")
      expect(tea.price).to eq(38.34)
    end
  end
end
