require_relative "taql/table"
require_relative "taql/version"

module Taql
  class Error < StandardError; end

  def self.execute(query)
    ActiveRecord::Base.connection.execute(query).tap do |result|
      Table.new(result.entries).print
    end
  end
end
