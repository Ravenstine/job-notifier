class AgentsListing < ActiveRecord::Base
  belongs_to :agent
  belongs_to :listing
  after_create :notify_agent
  def valid? context=nil
    super && passes_whitelist? && passes_blacklist?
  end
  private
  def passes_whitelist?
    values = agent.whitelist.split(",").map(&:strip)
    values.all?{|value| listing.description.downcase.include?(value.downcase)}
  rescue
    true
  end
  def passes_blacklist?
    values = agent.blacklist.split(",").map(&:strip)
    !values.any?{|value| listing.description.downcase.include?(value.downcase)}
  rescue
    true
  end
  def notify_agent
    agent.notify listing
  end
end
