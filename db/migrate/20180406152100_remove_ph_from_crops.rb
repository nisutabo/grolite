class RemovePhFromCrops < ActiveRecord::Migration[5.2]
  def change
    remove_column :crops, :ph, :integer
  end
end
