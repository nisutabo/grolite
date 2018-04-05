class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :crop_id

      t.timestamps
    end
  end
end
