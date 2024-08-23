require_relative "taql/cli"
require_relative "taql/table"
require_relative "taql/version"

module Taql
  class Error < StandardError; end

  def self.execute(query)
    ActiveRecord::Base.connection.execute(query).tap do |result|
      $stdout.puts Table.new(result.entries)
    end
  end
end
