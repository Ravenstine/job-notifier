class Listing < ActiveRecord::Base
  has_many :agents_listings
  has_many :agents, through: :agents_listings

  private
  def self.create_unless_exists params
    where(remote_id: params[:remote_id], agent_id: params[:agent_id]).first_or_create(params)
  end
end
