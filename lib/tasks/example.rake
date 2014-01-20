namespace :eligibility do
  desc "Check eligibility for customer"
  task :check_eligibility => :environment do
    subscriptions = [ "Music", "News", "Movies" ]
    rewards_service = AccountManagement::RewardsService.new(000336, subscriptions)
    puts rewards_service.perform
  end
end