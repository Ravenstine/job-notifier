class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :name
      t.string :person
      t.string :company
      t.text :description
      t.datetime :time
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :appointments, :users
    add_index :appointments, :time
  end
end
