class RemoveEcFromCrops < ActiveRecord::Migration[5.2]
  def change
    remove_column :crops, :ec, :integer
  end
end
