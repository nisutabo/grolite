class AddPhToCrops < ActiveRecord::Migration[5.2]
  def change
    add_column :crops, :ph, :float
  end
end
