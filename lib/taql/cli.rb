require "optparse"

module Taql
  class Cli
    attr_reader :options, :query

    def initialize(argv)
      @argv = argv
      @options = {markdown: false}
      @query = parse!

      raise ArgumentError, "Usage: taql [--markdown] QUERY" if @query.empty?
    end

    def run
      silence { require environment_path }

      Taql.execute(*query, options)
    end

    private

    def environment_path
      File.expand_path("config/environment", Dir.pwd)
    end

    def parse!
      OptionParser.new do |parser|
        parser.on("-m", "--markdown", TrueClass, "Output table in Markdown")
        parser.program_name = "taql"
        parser.version = Taql::VERSION
      end.parse!(@argv, into: options)
    end

    def silence
      original_stdout = $stdout.dup
      $stdout.reopen(IO::NULL)
      yield
    ensure
      $stdout.reopen(original_stdout)
    end
  end
end
