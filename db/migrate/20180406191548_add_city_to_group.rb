class AddCityToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :city, :string
  end
end
