class AddColumnsToCrop < ActiveRecord::Migration[5.2]
  def change
    add_column :crops, :name, :string
    add_column :crops, :scientific_name, :string
    add_column :crops, :crop_group, :string
    add_column :crops, :temp_day, :integer
    add_column :crops, :temp_night, :integer
    add_column :crops, :humidity, :integer
    add_column :crops, :ph, :integer
    add_column :crops, :ec, :integer
    add_column :crops, :dli, :integer
    add_column :crops, :sun_hours, :integer
    add_column :crops, :dth, :integer
  end
end
