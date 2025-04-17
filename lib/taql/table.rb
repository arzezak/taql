module Taql
  class Table
    DASH = "-".freeze
    PLUS = "+".freeze
    SPACE = " ".freeze
    VERTICAL_BAR = "|".freeze

    def initialize(entries)
      @entries = entries.map { |entry| entry.transform_values(&:to_s) }
    end

    def body
      entries.map(&:values)
    end

    def columns
      headers.map do |header|
        [header, *entries.map { |entry| entry[header] }]
      end
    end

    def headers
      entries.map(&:keys).uniq.flatten
    end

    def print
      output if entries.any?
    end

    def rows
      [headers, *body]
    end

    private

    attr_reader :entries

    def column_widths
      columns.map { |column| column.map(&:length).max }
    end

    def formatted(segments)
      segments.map.with_index do |segment, index|
        [SPACE, segment.ljust(column_widths[index]), SPACE].join
      end.then do |segments|
        [VERTICAL_BAR, segments.join(VERTICAL_BAR), VERTICAL_BAR].join
      end
    end

    def output
      <<~OUTPUT
        #{separator}
        #{formatted(headers.map(&:upcase))}
        #{separator}
        #{body.map(&method(:formatted)).join("\n")}
        #{separator}
      OUTPUT
    end

    def separator
      columns.map.with_index do |column, index|
        Array.new(column_widths[index] + 2, DASH).join
      end.then do |columns|
        [PLUS, columns.join(PLUS), PLUS].join
      end
    end
  end
end
