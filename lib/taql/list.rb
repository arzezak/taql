module Taql
  class List
    DASH = "-".freeze
    PIPE = " | ".freeze

    def initialize(entries, terminal_width: nil)
      @entries = entries.map { |entry| entry.transform_values(&:to_s) }
      @terminal_width = terminal_width
    end

    def print
      output if entries.any?
    end

    private

    attr_reader :entries

    def headers
      @headers ||= entries.flat_map(&:keys).uniq
    end

    def max_header_width
      @max_header_width ||= headers.map(&:length).max
    end

    def divider_width
      @terminal_width&.finite? ? @terminal_width : 32
    end

    def output
      records = entries.map { |entry| [separator, *rows(entry)].join("\n") }

      [*records, separator].join("\n")
    end

    def separator
      DASH * divider_width
    end

    def rows(entry)
      headers.map do |header|
        "#{header.upcase.rjust(max_header_width)}#{PIPE}#{entry[header]}"
      end
    end

    alias_method :to_s, :print
  end
end
