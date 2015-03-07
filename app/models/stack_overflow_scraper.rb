class StackOverflowScraper < RssScraper
  def initialize terms=nil, location=nil, agent=nil
    super
    @uri = URI.parse "http://careers.stackoverflow.com/jobs/feed?searchTerm=#{url_safe_string(@terms)}&location=#{url_safe_string(@location)}&range=20&distanceUnits=Miles"
  end
  def write
    items = @response["rss"]["channel"]["item"]
    items.if true: -> { 
      items.each do |item|
        Listing.where(remote_id: item["guid"]).first_or_create({
          title: item["title"],
          description: item["description"],
          # location: item["description"].match(/<strong>\((.+)\)<\/strong>/)[1],
          # company: item["description"].match(/<strong>About (.+?):<\/strong>/)[1],
          url: item["link"],
          posted_at: item["pubDate"],
          full_time: !item["description"].match(/full[- ]*time/i).nil?,
          part_time: !item["description"].match(/part[- ]*time/i).nil?,
          board_id: 1
        })
      end
    }
  rescue
  end
end