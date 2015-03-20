class Agent < RexModel
  has_many :agents_listings
  has_many :listings, through: :agents_listings
  belongs_to :location
  belongs_to :user
  before_create :assign_name
  validates :terms, presence: true

  # include RexModel
  attr_accessor :location_name, :jobs_found

  def find_new_listings scraper_class
    scraper = scraper_class.new self
    scraper.download
    scraper.write
  end
  def notify listing
    # ListingsMailer.notify("benjamin@pixelstreetinc.com", listing).deliver_now
  end
  def activeness
    {true => "Active", false => "Inactive"}[active]
  end
  private
  def assign_name
    self.name = AGENT_NAMES.sample
  end
end
