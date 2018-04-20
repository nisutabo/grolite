class AddColumnsToReading < ActiveRecord::Migration[5.2]
  def change
    add_column :readings, :user_id, :integer
    add_column :readings, :group_id, :integer
    add_column :readings, :ph, :float
    add_column :readings, :ec, :float
    add_column :readings, :date, :datetime
  end
end
