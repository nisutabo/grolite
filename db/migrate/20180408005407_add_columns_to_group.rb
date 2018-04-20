class AddColumnsToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :crop_name, :string
    add_column :groups, :crop_group, :string
    add_column :groups, :scientific_name, :string
  end
end
