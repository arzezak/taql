module Taql
  class Table
    attr_reader :entries

    def initialize(entries)
      @entries = entries
    end

    def print
      <<~OUTPUT
        #{separator}
        #{formatted_headers}
        #{separator}
        #{formatted_entries.join("\n")}
        #{separator}
      OUTPUT
    end

    def to_s
      print
    end

    def formatted_entries
      entries.each_with_object([]) do |entry, result|
        individual_entry = entry
          .map { |key, value| value.to_s.ljust(rows_max_length[key]) }
          .join(" | ")

        result << "| #{individual_entry} |"
      end
    end

    def formatted_headers
      output = headers.map do |header|
        header.upcase.ljust(rows_max_length[header])
      end.join(" | ")

      "| #{output} |"
    end

    def headers
      first.keys
    end

    def rows
      entries.each_with_object(
        Hash.new { |hash, key| hash[key] = [] }
      ) do |entry, result|
        entry.each do |header, value|
          result[header] << value
        end
      end
    end

    def rows_max_length
      rows_with_headers.each_with_object({}) do |(key, values), result|
        result[key] = values.map { _1.to_s.length }.max
      end
    end

    def rows_with_headers
      headers.each_with_object({}) do |column, result|
        result[column] = rows[column].unshift(column)
      end
    end

    def separator
      line = rows_with_headers.values.map do |values|
        length = values.map { _1.to_s.length }.max + 2
        Array.new(length, "-").join
      end.join("+")

      "+#{line}+"
    end

    private

    def first
      entries.first
    end
  end
end
