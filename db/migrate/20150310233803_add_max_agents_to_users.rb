class AddMaxAgentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :max_agents, :integer, default: 5
  end
end
