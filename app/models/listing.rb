class Listing < ActiveRecord::Base
  # attr_accessor :board_name
  has_many :agents_listings
  has_many :agents, through: :agents_listings

  def self.default_select
    "listings.*, (SELECT boards.name FROM boards WHERE boards.id=listings.board_id) AS board_name, IFNULL(agents_listings.read, 0) AS _read"
  end

  def mark_read user
    sql = "
      SELECT agents_listings.* FROM users
      INNER JOIN agents ON users.id = agents.user_id
      INNER JOIN agents_listings ON agents_listings.agent_id = agents.id AND agents_listings.listing_id=#{id}
      WHERE users.id=#{user.id}
      LIMIT 1
    "

    result = ActiveRecord::Base.connection.exec_query(sql).first
    result.if true: ->{
      agents_listing = AgentsListing.find(result["id"])
      agents_listing.update read: true
    }, false: ->{
      false
    }
  end

  def read?
    {true => true, false => false, 0 => false, 1 => true}[_read]
  rescue
    false
  end

  def read_class
    read?.if true: ->{"read"}, false: ->{"unread"}
  end

  private
  def self.create_unless_exists params
    where(remote_id: params[:remote_id], agent_id: params[:agent_id]).first_or_create(params)
  end
end
