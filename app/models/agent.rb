class Agent < ActiveRecord::Base
  has_many :agents_listings
  has_many :listings, through: :agents_listings
  belongs_to :location
  def find_new_listings scraper_class
    scraper = scraper_class.new self
    scraper.download
    scraper.write
  end
  def notify listing
    ListingsMailer.notify("benjamin@pixelstreetinc.com", listing).deliver_now
  end
end
