require "rails/railtie"

module Taql
  class Railtie < Rails::Railtie
    railtie_name :taql

    initializer "taql.initialize" do
      ActiveSupport.on_load(:active_record) do
        Taql.instance_variable_set(:@default_connection, -> { ActiveRecord::Base.connection_pool.connection })
      end
    end
  end
end
