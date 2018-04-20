class RemoveHumidityFromCrops < ActiveRecord::Migration[5.2]
  def change
    remove_column :crops, :humidity, :integer
  end
end
