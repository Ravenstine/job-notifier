class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.belongs_to :board
      t.string :remote_id
      t.string :title
      t.text :description
      t.string :company
      t.string :url
      t.string :tags
      t.string :location
      t.boolean :remote, default: false
      t.boolean :offers_relocation, default: false
      t.boolean :full_time, default: false
      t.boolean :part_time, default: false
      t.boolean :contract, default: false
      t.boolean :freelance, default: false
      t.boolean :internship, default: false
      t.boolean :moonlighting, default: false
      t.boolean :telecommute, default: false
      t.datetime :posted_at
      t.timestamps null: false
    end
  end
end
