class AddTempNightMinToCrops < ActiveRecord::Migration[5.2]
  def change
    add_column :crops, :temp_night_min, :integer
  end
end
