class AddTempDayMinToCrops < ActiveRecord::Migration[5.2]
  def change
    add_column :crops, :temp_day_min, :integer
  end
end
