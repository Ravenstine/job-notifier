class StackOverflowScraper < RssScraper
  def initialize agent
    super
    @uri = URI.parse "http://careers.stackoverflow.com/jobs/feed?searchTerm=#{url_safe_string(@terms)}&location=#{url_safe_string(@location.city_and_state)}&range=20&distanceUnits=Miles"
    @board_id = 1
  end
  def write
    items   = @response["rss"]["channel"]["item"]
    attribs = lambda { |item|
      {
        title: item["title"],
        description: item["description"],
        url: item["link"],
        posted_at: item["pubDate"],
        full_time: !item["description"].match(Regex::Fulltime).nil?,
        part_time: !item["description"].match(Regex::Parttime).nil?,
        board_id: @board_id,
        remote_id: item["guid"]
      }
    }
    write_listing items, attribs, @agent
  rescue
  end
end