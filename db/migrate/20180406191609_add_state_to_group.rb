class AddStateToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :state, :string
  end
end
