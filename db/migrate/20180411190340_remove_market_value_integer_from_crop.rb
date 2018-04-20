class RemoveMarketValueIntegerFromCrop < ActiveRecord::Migration[5.2]
  def change
    remove_column :crops, :market_value_integer, :string
  end
end
