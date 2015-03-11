class CraigslistScraper < RssScraper
  def initialize agent
    super
    @uri = URI.parse("http://#{@location.craigslist_prefix}.craigslist.org/search/jjj?query=#{url_safe_string(@terms)}&sort=date&format=rss")
    @board_id = 4
  end
  def download
    @response = Nokogiri::XML(Net::HTTP.get(@uri)).css("item").to_a.map{|i| Nori.new.parse(i.to_xml)["item"]}.reject{|i| i.nil?}
  end
  def write
    items   = @response rescue []
    attribs = lambda { |item|
      {
        title: item["title"],
        description: item["description"],
        url: item["link"],
        posted_at: item["dc:date"] || item["issued"],
        full_time: !item["description"].match(Regex::Fulltime).nil?,
        part_time: !item["description"].match(Regex::Parttime).nil?,
        board_id: @board_id,
        remote_id: item["link"]
      }
    }

    callback = lambda{|listing|
      extract_email_from_description(listing) || extract_anonemail(listing)
    }

    write_listing items, attribs, @agent, callback 
  end

  private
  def extract_anonemail listing
    uri = URI.parse(listing.url)
    doc = Nokogiri::HTML Net::HTTP.get(uri)

    replylink = doc.css("#replylink").first.attributes["href"].value rescue nil

    replylink.if true: -> do
      new_link = URI.parse("#{uri.scheme}://#{uri.host}#{replylink}")
      doc = Nokogiri::HTML Net::HTTP.get(new_link)
      listing.contact_email = doc.css(".anonemail").first.children.first.text rescue nil
      listing.save
    end    
    listing.contact_email
  end
end