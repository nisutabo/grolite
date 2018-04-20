class AddMinhumidityToCrops < ActiveRecord::Migration[5.2]
  def change
    add_column :crops, :minhumidity, :integer
  end
end
