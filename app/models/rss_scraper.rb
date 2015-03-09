class RssScraper
  require 'uri'
  require 'net/http'
  attr_accessor :response, :terms, :location, :uri
  def initialize agent
    @response = nil
    @terms = agent.terms
    @location = agent.location
    @agent = agent
    @agent.if true: ->{ @agent_id = @agent.id }
  end
  def download
    parser = Nori.new
    @response = parser.parse Net::HTTP.get(@uri)
  end
private
  def url_safe_string string
    URI.escape string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")
  end
  def write_listing items, attribs, agent
    items.if true: -> { 
      items.each do |item|
        listing = Listing.create_unless_exists attribs.call(item)
        agent.agents_listings.where(listing_id: listing.id, agent_id: agent.id).first_or_create
      end
    }
  end
end