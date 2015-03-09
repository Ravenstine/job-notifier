class AgentsListing < ActiveRecord::Base
  belongs_to :agent
  belongs_to :listing
  after_create :notify_agent
  private
  def notify_agent
    agent.notify listing
  end
end
