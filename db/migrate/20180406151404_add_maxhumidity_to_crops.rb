class AddMaxhumidityToCrops < ActiveRecord::Migration[5.2]
  def change
    add_column :crops, :maxhumidity, :integer
  end
end
