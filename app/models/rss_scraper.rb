class RssScraper
  require 'uri'
  require 'net/http'
  attr_accessor :response, :terms, :location, :uri
  def initialize terms=nil, location=nil, agent=nil
    @response = nil
    @terms = terms
    @location = location
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
end