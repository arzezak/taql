require_relative "taql/cli"
require_relative "taql/table"
require_relative "taql/version"
require_relative "taql/railtie" if defined?(Rails)

module Taql
  class << self
    attr_writer :default_connection

    def execute(query, options = {}, connection: nil)
      (connection || default_connection).execute(query).tap do |result|
        if (results = result.entries).any?
          $stdout.puts Table.new(results, markdown: options[:markdown])
        end
      end
    end

    private

    def default_connection
      @default_connection&.call || raise("Taql not properly initialized with Rails")
    end
  end
end
