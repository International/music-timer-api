class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :name
      t.decimal :seconds
      t.integer :state
      t.timestamp :recorded_at
      t.integer :piece_id

      t.timestamps null: false
    end
  end
end
