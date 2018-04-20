class AddEcToCrops < ActiveRecord::Migration[5.2]
  def change
    add_column :crops, :ec, :float
  end
end
