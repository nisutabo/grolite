class RemoveLocationFromGroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :location, :string
  end
end
