class CraigslistScraper < RssScraper
  def initialize agent
    super
    @uri = URI.parse("http://#{@location.craigslist_prefix}.craigslist.org/search/jjj?query=#{url_safe_string(@terms)}&sort=date&format=rss")
    @board_id = 4
  end
  def download    
    request = Net::HTTP::Get.new(@uri)
    request.add_field 'User-Agent', "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36"
    response = Net::HTTP.start(@uri.host, @uri.port){|http| http.request(request)}.body
    @response = Nokogiri::XML(response).css("item").to_a.map{|i| Nori.new.parse(i.to_xml)["item"]}.reject{|i| i.nil?}
    # require 'socksify/http'https://techblog.willshouse.com/2012/01/03/most-common-user-agents/
    # Net::HTTP.SOCKSProxy('127.0.0.1', 9050).start(@uri.host, @uri.port) do |http|
    #   result = http.get(@uri.path)
    #   @response = Nokogiri::XML(result).css("item").to_a.map{|i| Nori.new.parse(i.to_xml)["item"]}.reject{|i| i.nil?}
    # end
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

    write_listings items, attribs, @agent, callback 
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