class Article < ApplicationRecord
  include MarkdownConcern
  include PaginationConcern

  ALLOWED_TAGS = %w(table thead tbody td th tr p ul ol li h1 h2 h3 h4 h5 h6 h7 code em a img)

  convert_markdown :body

  attr_accessor :skip_date_validation

  belongs_to :admin
  belongs_to :feed, optional: true

  scope :published, -> {where('publish_date < ?', Time.now).order(publish_date: :desc)}

  validates_presence_of :body, :publish_date
  validate :publish_date_in_future, on: :create, if: -> {!skip_date_validation}

  before_validation :set_publish_date
  before_validation :detect_emoji

  def source_name
    unless source.blank?
      source.split('/').select{|s| s.include? '.'}.first
    end
  end

  private

  def publish_date_in_future
    if self.publish_date && self.publish_date < Time.now
      self.errors.add(:publish_date, "Must be in future")
    end
  end

  def set_publish_date
    if self.publish_date.blank?
      self.publish_date = 1.minute.from_now
    end
  end

  def detect_emoji
    if self.emoji.blank?
      emojis = body.scan(Unicode::Emoji::REGEX)

      if emojis.length > 0
        self.emoji = emojis[0]
      end
    end
  end
end
