namespace :listings do
  desc "TODO"
  task update: :environment do
    Agent.all.each do |agent|
      agent.find_new_listings AuthenticJobsScraper
      agent.find_new_listings GithubScraper
      agent.find_new_listings StackOverflowScraper
    end
  end
end