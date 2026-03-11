require "rails/railtie"

module Taql
  class Railtie < Rails::Railtie
    railtie_name :taql

    initializer "taql.initialize" do
      ActiveSupport.on_load(:active_record) do
        Taql.instance_variable_set(:@default_connection, method(:connection))
      end
    end

    def self.connection
      pool = ActiveRecord::Base.connection_pool
      pool.respond_to?(:lease_connection) ? pool.lease_connection : pool.connection
    end
  end
end
