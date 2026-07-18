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

    def active_record_connection
      pool = ActiveRecord::Base.connection_pool
      pool.respond_to?(:lease_connection) ? pool.lease_connection : pool.connection
    end

    private

    def formatter(results, markdown:)
      table = Table.new(results, markdown: markdown)
      width = terminal_width

      if !markdown && width && table.table_width > width
        List.new(results, terminal_width: width)
      else
        table
      end
    end

    def terminal_width
      IO.console&.winsize&.last
    end

    def default_connection
      @default_connection&.call || raise("Taql not properly initialized with Rails")
    end
  end
end
