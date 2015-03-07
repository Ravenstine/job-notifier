class GithubScraper < RssScraper
  def initialize terms=nil, location=nil
    super
    @uri = URI.parse "https://jobs.github.com/positions.atom?description=#{url_safe_string(@terms)}&location=#{url_safe_string(@location)}"
  end
  def write
    items = @response["feed"]["entry"]
    items.if true: -> { 
      items.each do |item|
        Listing.where(remote_id: item["id"]).first_or_create({
          title: item["title"],
          description: item["content"],
          # location: item["description"].match(/<strong>\((.+)\)<\/strong>/)[1],
          # company: item["description"].match(/<strong>About (.+?):<\/strong>/)[1],
          url: item["link"],
          posted_at: item["updated"],
          full_time: !item["content"].match(/full[- ]*time/i).nil?,
          part_time: !item["content"].match(/part[- ]*time/i).nil?,
          board_id: 2,
          agent_id: @agent_id
        })
      end
    }
  rescue
  end
end