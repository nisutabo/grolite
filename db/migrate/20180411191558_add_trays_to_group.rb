class AddTraysToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :trays, :integer
  end
end
