namespace :feed_runner do
  desc "Fetch feed"
  task fetch_feed: [:environment] do |t, args|
    FeedJob.perform_now
  end
end
