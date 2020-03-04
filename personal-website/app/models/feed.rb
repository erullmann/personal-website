require 'net/http'
require 'uri'

class Feed < ApplicationRecord
  belongs_to :admin
  has_many :articles

  validates_presence_of :url, :name
  validates_numericality_of :minutes_between_fetches, greater_than_or_equal_to: 5
  validates :url, :presence => true, :url => true

  def retrieve_feed
    if last_fetched_at.nil? || last_fetched_at < minutes_between_fetches.minutes.ago
      feed = Feedjira.parse(Net::HTTP.get_response(URI.parse(url)).body)

      feed.entries.each do |entry|
        article = Article.find_or_initialize_by(source: entry.url, feed: self)

        unless article.persisted?
          article.title = entry.title
          article.parsed_body = entry.summary || entry.content
          article.body = entry.summary || entry.content
          article.publish_date = entry.published
          article.skip_date_validation = true
          article.admin = self.admin
          article.save
        end
      end
      self.last_fetched_at = Time.now
      self.save
    end
  end
end
