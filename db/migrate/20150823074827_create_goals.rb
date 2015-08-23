class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :time_unit
      t.decimal :unit_value
      t.integer :piece_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
