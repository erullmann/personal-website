class Article < ApplicationRecord
  attr_accessor :skip_date_validation

  belongs_to :admin

  scope :published, -> {where('publish_date < ?', Time.now).order(publish_date: :desc)}

  validates_presence_of :title, :body, :publish_date
  validate :publish_date_in_future, on: :create, if: -> {!skip_date_validation}

  before_validation :set_publish_date

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
end
