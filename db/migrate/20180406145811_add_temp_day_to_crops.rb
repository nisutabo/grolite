class AddTempDayToCrops < ActiveRecord::Migration[5.2]
  def change
    add_column :crops, :temp_day, :integer
  end
end
