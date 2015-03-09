class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :terms
      t.belongs_to :location
      t.belongs_to :user
      t.boolean :auto_send_resume, default: true
      t.boolean :active, default: true
      t.boolean :email_updates, default: true
      t.string :whitelist
      t.string :blacklist
      t.timestamps null: false
    end
    add_index :agents, :user_id
    add_index :agents, :active
  end
end
