class AddCraigslistPrefixToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :craigslist_prefix, :string
  end
end
