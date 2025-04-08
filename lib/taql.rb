require_relative "taql/cli"
require_relative "taql/table"
require_relative "taql/version"

module Taql
  class Error < StandardError; end

  def self.execute(query)
    ActiveRecord::Base.connection.execute(query).tap do |result|
      if (results = result.entries).any?
        $stdout.puts Table.new(results)
      end
    end
  end
end
