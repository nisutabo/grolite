class AddProductionDateToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :production_date, :datetime
  end
end
