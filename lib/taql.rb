require "io/console"
require_relative "taql/cli"
require_relative "taql/list"
require_relative "taql/table"
require_relative "taql/version"
require_relative "taql/railtie" if defined?(Rails)

module Taql
  class << self
    attr_writer :default_connection

    def execute(query, options = {}, connection: nil)
      (connection || default_connection).execute(query).tap do |result|
        if (results = result.entries).any?
          $stdout.puts formatter(results, markdown: options[:markdown])
        end
      end
    end

    private

    def formatter(results, markdown: false)
      table = Table.new(results, markdown: markdown)
      if !markdown && table.table_width > terminal_width
        List.new(results, terminal_width: terminal_width)
      else
        table
      end
    end

    def terminal_width
      IO.console&.winsize&.last || Float::INFINITY
    end

    def default_connection
      @default_connection&.call || raise("Taql not properly initialized with Rails")
    end
  end
end
