require "optparse"

module Taql
  class Cli
    attr_reader :options, :query

    def initialize(argv)
      @options = {markdown: false}
      @query = parse!
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
      end.parse!(into: options)
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
