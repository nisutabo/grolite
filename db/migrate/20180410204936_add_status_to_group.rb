class AddStatusToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :status, :string
  end
end
