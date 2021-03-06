class RssScraper
  require 'uri'
  require 'net/http'
  require 'rss'
  require 'open-uri'
  attr_accessor :response, :terms, :location, :uri
  
  module Regex
    Fulltime = /full[- ]*time/i
    Parttime = /part[- ]*time/i
    Email = /(\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b)/i
  end

  def initialize agent
    @response = nil
    @terms = agent.terms
    @location = agent.location || OpenStruct.new({})
    @agent = agent
    @agent.if true: ->{ @agent_id = @agent.id }
  end
  def download
    puts "Downloading..."
    parser = Nori.new
    @response = parser.parse Net::HTTP.get(@uri)
    puts "Downloaded."
  end
private
  def url_safe_string string
    URI.escape string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")
  end
  def write_listings items, attribs, agent, callback=Proc.new{}
    puts "Writing listings..."
    date_threshold = agent.listings.order("posted_at DESC").last
    # date_threshold = ActiveRecord::Base.connection.execute("SELECT MAX(posted_at) FROM listings WHERE board_id = #{@board_id}").first
    date_threshold.if true: ->{ date_threshold = date_threshold.posted_at }
    date_threshold = date_threshold || 100.years.ago
    items.if true: -> { 
      items.each do |item|
        write_listing item, attribs, date_threshold, callback, agent
      end
    }
    puts "Listings written."
  end
  def extract_email_from_description listing
    listing.contact_email = listing.description.match(Regex::Email).to_a.last rescue nil
  end
  def write_listing item, attribs, date_threshold, callback, agent
    puts "Writing a listing..."
    props = attribs.call(item)
    (date_threshold < props[:posted_at]).if true: ->{
      ActiveRecord::Base.transaction do
        listing = Listing.where(props).first_or_create props
        extract_email_from_description listing
        listing.save
        callback.call(listing)
        agent.agents_listings.where(listing_id: listing.id, agent_id: agent.id).first_or_create
      end
    }
    puts "Finished writing a listing."
  end
end