class AddPropagationDateToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :propagation_date, :datetime
  end
end
