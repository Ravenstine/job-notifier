class AuthenticJobsScraper < RssScraper
  def initialize agent
    super
    @uri = URI.parse("http://www.authenticjobs.com/rss/custom.php?terms=#{url_safe_string(@terms)}&type=1,3,5,2,6,4&location=#{url_safe_string(@location.city_and_state)}")
    @board_id = 3
  end
  def download
    @response = Nokogiri::XML(Net::HTTP.get(@uri)).css("item").to_a.map{|i| Nori.new.parse(i.to_xml)["item"]}.reject{|i| i.nil?}
  end
  def write
    # items   = @response["rss"]["channel"]["item"]
    items = @response
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
    write_listings items, attribs, @agent
  end
end