class AuthenticJobsScraper < RssScraper
  def initialize terms=nil, location=nil, agent=nil
    super
    @uri = URI.parse("http://www.authenticjobs.com/rss/custom.php?terms=#{url_safe_string(@terms)}&type=1,3,5,2,6,4&location=#{url_safe_string(@location)}")
  end
  def write
    items = @response["rss"]["channel"]["item"]
    items.if true: -> { 
      items.each do |item|
        Listing.where(remote_id: item["guid"]).first_or_create({
          title: item["title"],
          description: item["description"],
          location: item["description"].match(/<strong>\((.+)\)<\/strong>/)[1],
          company: item["description"].match(/<strong>About (.+?):<\/strong>/)[1],
          url: item["link"],
          posted_at: item["pubDate"],
          full_time: !item["description"].match(/<p>Full-time<\/p>/).nil?,
          part_time: !item["description"].match(/<p>Part-time<\/p>/).nil?,
          board_id: 3,
          agent_id: @agent_id
        })
      end
    }
  rescue
  end
end