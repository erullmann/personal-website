require 'active_support/concern'

module OffsetConcern
  extend ActiveSupport::Concern

  DEFAULT_LIMIT = 12

  included do
    class_attribute :default_offset_value
    class_attribute :default_limit_value

    default_limit DEFAULT_LIMIT
  end

  class_methods do
    def default_offset(offset)
      self.default_offset_value = offset
    end

    def default_limit(limit)
      self.default_limit_value = limit
    end
  end

  def limit_param
    @limit ||= get_limit
  end

  def offset_param
    @offset ||= get_offset
  end

  private

  def get_offset
    if params[:offset]
      begin
        params[:offset].to_i
      rescue Exception => e
        0
      end
    else
      0
    end
  end

  def get_limit
    if params[:limit]
      begin
        params[:limit].to_i
      rescue Exception => e
        self.class.default_limit_value
      end
    else
      self.class.default_limit_value
    end
  end
end