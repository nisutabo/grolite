class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.datetime :seed_date
      t.datetime :harvest_date
      t.integer :germination_days
      t.integer :propagation_days
      t.integer :production_days
      t.integer :expected_harvest_lbs
      t.integer :actual_harvest_lbs
      t.boolean :harvested

      t.timestamps
    end
  end
end
