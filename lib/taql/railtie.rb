require "rails/railtie"

module Taql
  class Railtie < Rails::Railtie
    railtie_name :taql

    initializer "taql.initialize" do
      ActiveSupport.on_load(:active_record) do
        Taql.default_connection = Taql.method(:active_record_connection)
      end
    end
  end
end
