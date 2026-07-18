require_relative "formatter"

module Taql
  class Table < Formatter
    PLUS = "+".freeze
    SPACE = " ".freeze
    VERTICAL_BAR = "|".freeze

    attr_reader :markdown

    def initialize(entries, markdown: false)
      super(entries)
      @markdown = markdown
    end

    def table_width
      column_widths.sum + (3 * headers.count) + 1
    end

    def body
      entries.map(&:values)
    end

    private

    def border
      separator unless markdown
    end

    def column_widths
      @column_widths ||= headers.map do |header|
        [header, *entries.map { |entry| entry[header] }].map(&:length).max
      end
    end

    def edge
      markdown ? VERTICAL_BAR : PLUS
    end

    def formatted(segments)
      segments.map.with_index do |segment, index|
        [SPACE, segment.ljust(column_widths[index]), SPACE].join
      end.then do |segments|
        [VERTICAL_BAR, segments.join(VERTICAL_BAR), VERTICAL_BAR].join
      end
    end

    def output
      [
        border,
        formatted(headers.map(&:upcase)),
        separator,
        body.map(&method(:formatted)).join("\n"),
        border
      ].compact.join("\n")
    end

    def separator
      column_widths.map do |width|
        DASH * (width + 2)
      end.then do |segments|
        [edge, segments.join(edge), edge].join
      end
    end
  end
end
