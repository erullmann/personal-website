require 'active_support/concern'

module PaginationConcern
  extend ActiveSupport::Concern

  DEFAULT_PAGE_SIZE = 10

  included do
    class_attribute :page_size_value

    page_size DEFAULT_PAGE_SIZE


  end

  class_methods do
    def page_size(page_size)
      self.page_size_value = page_size
    end

    def page(page=1)
      if page.blank? || page < 1
        page = 1
      end
      limit(self.page_size_value).offset((page - 1) * self.page_size_value)
    end

    def total_pages
      (count / self.page_size_value).ceil
    end
  end
end