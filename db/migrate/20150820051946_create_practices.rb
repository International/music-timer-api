class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :name
      t.decimal :seconds
      t.string :state
      t.string :integer
      t.string :recorded_at
      t.string :timestamp
      t.integer :piece_id

      t.timestamps null: false
    end
  end
end
