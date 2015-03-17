class AddSearchIndex < ActiveRecord::Migration
  def change
    add_index :listings, [:description, :title, :contact_email], name: 'description_title_contact_email', type: :fulltext
  end
end
