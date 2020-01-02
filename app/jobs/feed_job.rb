class FeedJob < ApplicationJob
  def perform
    puts "Performing feed job"

    Feed.where("last_fetched_at IS NULL OR last_fetched_at + (minutes_between_fetches ||' minutes')::interval < current_timestamp").all.find_each do |feed|
      puts "Retrieving feed for #{feed.name}"

      feed.retrieve_feed
    end
  end
end