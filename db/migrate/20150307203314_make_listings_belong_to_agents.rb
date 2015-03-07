class MakeListingsBelongToAgents < ActiveRecord::Migration
  def change
    add_column :listings, :agent_id, :integer
    add_index :listings, :agent_id
  end
end
