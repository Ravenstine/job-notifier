class AddIndices < ActiveRecord::Migration
  def change
    add_index :listings, :created_at
    add_index :listings, :updated_at
    add_index :agents_listings, :agent_id
    add_index :agents_listings, :listing_id
  end
end
