class CreateAgentsListings < ActiveRecord::Migration
  def change
    create_table :agents_listings do |t|
      t.belongs_to :agent
      t.belongs_to :listing
      t.timestamps null: false
    end
  end
end
