class GithubScraper < RssScraper
  def initialize agent
    super
    @uri = URI.parse "https://jobs.github.com/positions.atom?description=#{url_safe_string(@terms)}&location=#{url_safe_string(@location.city_and_state)}"
  end
  def write
    items   = @response["feed"]["entry"]
    attribs = lambda { |item|
      {
        title: item["title"],
        description: item["content"],
        url: item["link"],
        posted_at: item["updated"],
        full_time: !item["content"].match(/full[- ]*time/i).nil?,
        part_time: !item["content"].match(/part[- ]*time/i).nil?,
        board_id: 2,
        remote_id: item["id"]
      }
    }
    write_listing items, attribs, @agent
  rescue
  end
end