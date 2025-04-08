module Taql
  class Table
    DASH = "-".freeze
    PLUS = "+".freeze
    SPACE = " ".freeze
    VERTICAL_BAR = "|".freeze

    def initialize(entries)
      @entries = entries.map { it.transform_values(&:to_s) }
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

    def formatted(segments)
      segments.map do |segment|
        cell_index = segments.index(segment)
        max_length = columns[cell_index].map(&:length).max
        [SPACE, segment.ljust(max_length), SPACE].join
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
      columns.map do |column|
        column_index = columns.index(column)
        max_length = columns[column_index].map(&:length).max
        Array.new(max_length + 2, DASH).join
      end.then do |columns|
        [PLUS, columns.join(PLUS), PLUS].join
      end
    end
  end
end
