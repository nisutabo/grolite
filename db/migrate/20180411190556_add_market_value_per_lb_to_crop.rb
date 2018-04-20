class AddMarketValuePerLbToCrop < ActiveRecord::Migration[5.2]
  def change
    add_column :crops, :market_value, :integer
  end
end
