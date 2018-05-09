class AddDliMinToCrops < ActiveRecord::Migration[5.2]
  def change
    add_column :crops, :dli_min, :integer
  end
end
