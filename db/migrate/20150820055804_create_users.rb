class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :encrypted_password
      t.string :salt
      t.string :first_name
      t.string :last_name
      t.string :profile_image_url
      t.string :facebook_id
      t.integer :country_reference_id
      t.integer :state_reference_id
      t.integer :city_reference_id

      t.timestamps null: false
    end
  end
end
