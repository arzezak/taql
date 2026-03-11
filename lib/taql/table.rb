module Taql
  class Table
    DASH = "-".freeze
    PLUS = "+".freeze
    SPACE = " ".freeze
    VERTICAL_BAR = "|".freeze

    attr_accessor :markdown

    def initialize(entries, markdown: false)
      @entries = entries.map { |entry| entry.transform_values(&:to_s) }
      @markdown = markdown
    end

    def body
      entries.map(&:values)
    end

    def columns
      @columns ||= headers.map do |header|
        [header, *entries.map { |entry| entry[header] }]
      end
    end

    def headers
      @headers ||= entries.flat_map(&:keys).uniq
    end

    def print
      output if entries.any?
    end

    def rows
      [headers, *body]
    end

    private

    attr_reader :entries

    def border
      separator unless markdown
    end

    def column_widths
      @column_widths ||= columns.map { |column| column.map(&:length).max }
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
      columns.map.with_index do |column, index|
        Array.new(column_widths[index] + 2, DASH).join
      end.then do |columns|
        [edge, columns.join(edge), edge].join
      end
    end

    alias_method :to_s, :print
  end
end
