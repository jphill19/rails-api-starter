class AddImageToTeas < ActiveRecord::Migration[7.1]
  def change
    add_column :teas, :image, :string
  end
end
