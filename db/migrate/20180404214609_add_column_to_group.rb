class AddColumnToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :user_id, :integer
    add_column :groups, :crop_id, :integer
  end
end
