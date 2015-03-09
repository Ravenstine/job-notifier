class CraigslistScraper < RssScraper
  def initialize agent
    super
    @uri = URI.parse("http://#{@location.craigslist_prefix}.craigslist.org/search/jjj?query=#{url_safe_string(@terms)}&sort=date&format=rss")
    @board_id = 4
  end
  def write
    items   = @response["rdf:RDF"]["item"] rescue []
    attribs = lambda { |item|
      {
        title: item["title"],
        description: item["description"],
        url: item["link"],
        posted_at: item["dc:date"],
        full_time: !item["description"].match(/<p>Full-time<\/p>/).nil?,
        part_time: !item["description"].match(/<p>Part-time<\/p>/).nil?,
        board_id: @board_id,
        remote_id: item["link"]   
      }
    }
    write_listing items, attribs, @agent
  end
end