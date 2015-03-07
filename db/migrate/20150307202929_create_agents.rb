class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :terms
      t.string :location
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
