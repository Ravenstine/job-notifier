class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :county
      t.string :state
      t.string :country
      t.string :zip_code
      t.timestamps null: false
    end
  end
end
