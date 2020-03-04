require 'active_support/concern'

# Converts markdown in one column into HTML in another column
# Usage:
#
# class Foo
#   include MarkdownConcern
#   convert_markdown :body, :converted_body, highlight: true
module MarkdownConcern
  extend ActiveSupport::Concern

  DEFAULT_MARKDOWN_OPTIONS = {autolink: true, space_after_headers: true, tables: true, link_attributes: {rel: 'nofollow', target: "_blank"}}

  included do
    class_attribute :markdown_source_column
    class_attribute :markdown_destination_column
    class_attribute :markdown_conversion_options

    before_save :set_converted_markdown

    def reconvert_markdown
      self.set_converted_markdown(true)
      self.save
    end
  end

  class_methods do
    def convert_markdown(source_column, destination_column=nil, options={})
      if destination_column.blank?
        destination_column = "parsed_#{source_column}"
      end

      self.markdown_source_column = source_column
      self.markdown_destination_column = destination_column
      self.markdown_conversion_options = DEFAULT_MARKDOWN_OPTIONS.merge options
    end
  end

  protected

  def set_converted_markdown(force_convert=false)
    if force_convert || self.send("#{self.class.markdown_source_column}_changed?")
      self.send("#{self.class.markdown_destination_column}=", markdown_parser.render(self.send(self.class.markdown_source_column)))
    end
  end

  def markdown_parser
    @markdown_parser ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, self.class.markdown_conversion_options)
  end
end