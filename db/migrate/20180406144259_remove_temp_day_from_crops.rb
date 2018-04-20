class RemoveTempDayFromCrops < ActiveRecord::Migration[5.2]
  def change
    remove_column :crops, :temp_day, :integer
  end
end
