module Taql
  class Cli
    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def run
      silence { require environment_path }
      Taql.execute(*argv)
    end

    private

    def environment_path
      File.expand_path("config/environment", Dir.pwd)
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
