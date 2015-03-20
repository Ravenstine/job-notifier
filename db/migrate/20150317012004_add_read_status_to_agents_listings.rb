class AddReadStatusToAgentsListings < ActiveRecord::Migration
  def change
    add_column :agents_listings, :read, :boolean, default: false
    add_index :agents_listings, :read
  end
end
