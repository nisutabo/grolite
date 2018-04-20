class RemoveStateFromGroup < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :state, :string
  end
end
