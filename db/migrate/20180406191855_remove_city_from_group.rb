class RemoveCityFromGroup < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :city, :string
  end
end
