class RssScraper
  require 'uri'
  require 'net/http'
  require 'rss'
  require 'open-uri'
  attr_accessor :response, :terms, :location, :uri
  def initialize agent
    @response = nil
    @terms = agent.terms
    @location = agent.location
    @agent = agent
    @agent.if true: ->{ @agent_id = @agent.id }
  end
  def download
    parser = Nori.new #(:convert_tags_to => lambda { |tag| tag.gsub(":", "_") })
    @response = parser.parse Net::HTTP.get(@uri)
    # open(@uri) do |rss|
    #   @response = RSS::Parser.parse(rss)
    # end
  end
private
  def url_safe_string string
    URI.escape string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")
  end
  def write_listing items, attribs, agent
    date_threshold = ActiveRecord::Base.connection.execute("SELECT MAX(posted_at) FROM listings WHERE board_id = #{@board_id}").first
    date_threshold.if true: ->{ date_threshold = date_threshold.first }
    items.if true: -> { 
      items.each do |item|
        props = attribs.call(item)
        (date_threshold < props[:posted_at]).if true: ->{
          # listing = Listing.create_unless_exists props
          listing = Listing.create props
          agent.agent_listings.create listing_id: listing.id, agent_id: agent.id
          # agent.agents_listings.where(listing_id: listing.id, agent_id: agent.id).first_or_create
        }
      end
    }
  end
end