class AuthenticJobsScraper < RssScraper
  def initialize agent
    super
    @uri = URI.parse("http://www.authenticjobs.com/rss/custom.php?terms=#{url_safe_string(@terms)}&type=1,3,5,2,6,4&location=#{url_safe_string(@location.city_and_state)}")
  end
  def write
    items   = @response["rss"]["channel"]["item"]
    attribs = lambda { |item|
      {
        title: item["title"],
        description: item["description"],
        url: item["link"],
        posted_at: item["pubDate"],
        full_time: !item["description"].match(/<p>Full-time<\/p>/).nil?,
        part_time: !item["description"].match(/<p>Part-time<\/p>/).nil?,
        board_id: 3,
        remote_id: item["guid"]   
      }
    }
    write_listing items, attribs, @agent
  end
end