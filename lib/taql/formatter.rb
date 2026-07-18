module Taql
  class Formatter
    DASH = "-".freeze

    def initialize(entries)
      @entries = entries.map { |entry| entry.transform_values(&:to_s) }
    end

    def headers
      @headers ||= entries.flat_map(&:keys).uniq
    end

    def print
      output if entries.any?
    end

    alias_method :to_s, :print

    private

    attr_reader :entries
  end
end
