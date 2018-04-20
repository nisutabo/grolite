class AddMarketValueToCrop < ActiveRecord::Migration[5.2]
  def change
    add_column :crops, :market_value_integer, :string
  end
end
