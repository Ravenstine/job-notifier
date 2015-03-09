class StackOverflowScraper < RssScraper
  def initialize agent
    super
    @uri = URI.parse "http://careers.stackoverflow.com/jobs/feed?searchTerm=#{url_safe_string(@terms)}&location=#{url_safe_string(@location.city_and_state)}&range=20&distanceUnits=Miles"
  end
  def write
    items   = @response["rss"]["channel"]["item"]
    attribs = lambda { |item|
      {
        title: item["title"],
        description: item["description"],
        url: item["link"],
        posted_at: item["pubDate"],
        full_time: !item["description"].match(/full[- ]*time/i).nil?,
        part_time: !item["description"].match(/part[- ]*time/i).nil?,
        board_id: 1,
        remote_id: item["guid"]   
      }
    }
    write_listing items, attribs, @agent
  rescue
  end
end