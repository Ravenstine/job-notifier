class Agent < ActiveRecord::Base
  def find_new_listings scraper_class
    scraper = scraper_class.new terms, location
    scraper.download
    scraper.write
  end
end
