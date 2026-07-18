require_relative "formatter"

module Taql
  class List < Formatter
    PIPE = " | ".freeze

    def initialize(entries, terminal_width: nil)
      super(entries)
      @terminal_width = terminal_width
    end

    private

    def max_header_width
      @max_header_width ||= headers.map(&:length).max
    end

    def divider_width
      @terminal_width || 32
    end

    def output
      records = entries.map { |entry| [separator, *rows(entry)].join("\n") }

      [*records, separator].join("\n")
    end

    def separator
      @separator ||= DASH * divider_width
    end

    def rows(entry)
      headers.map do |header|
        "#{header.upcase.rjust(max_header_width)}#{PIPE}#{entry[header]}"
      end
    end
  end
end
