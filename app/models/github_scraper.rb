class GithubScraper < RssScraper
  def initialize agent
    super
    @uri = URI.parse "https://jobs.github.com/positions.atom?description=#{url_safe_string(@terms)}&location=#{url_safe_string(@location.city_and_state)}"
    @board_id = 2
  end
  def write
    items   = @response["feed"]["entry"]
    attribs = lambda { |item|
      {
        title: item["title"],
        description: item["content"],
        url: item["link"]["@href"],
        posted_at: item["updated"],
        full_time: !item["content"].match(Regex::Fulltime).nil?,
        part_time: !item["content"].match(Regex::Parttime).nil?,
        board_id: @board_id,
        remote_id: item["id"]
      }
    }
    write_listing items, attribs, @agent
  rescue
  end
end