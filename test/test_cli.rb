require "test_helper"
require "tmpdir"

class TestCli < Minitest::Test
  def test_that_it_parses_queries
    cli = Taql::Cli.new(["SELECT * FROM users"])

    assert_equal "SELECT * FROM users", *cli.query
    assert_equal false, cli.options[:markdown]
  end

  def test_that_it_parses_options
    cli = Taql::Cli.new(["--markdown", "SELECT * FROM users"])

    assert_equal "SELECT * FROM users", *cli.query
    assert_equal true, cli.options[:markdown]
  end

  def test_that_it_raises_without_query
    assert_raises(ArgumentError) { Taql::Cli.new([]) }
  end

  def test_that_it_prints_version
    assert_output("taql #{Taql::VERSION}\n") do
      assert_raises(SystemExit) { Taql::Cli.new(["--version"]) }
    end
  end

  def test_that_it_runs_the_query
    environment = File.join(File.realpath(Dir.mktmpdir), "config", "environment.rb")
    Dir.mkdir(File.dirname(environment))
    File.write(environment, "")
    cli = Taql::Cli.new(["--markdown", "SELECT 1"])
    executed = nil

    Dir.chdir(File.dirname(File.dirname(environment))) do
      Taql.stub(:active_record_connection, :connection) do
        Taql.stub(:execute, ->(*args, **kwargs) { executed = [args, kwargs] }) do
          cli.run
        end
      end
    end

    assert_includes $LOADED_FEATURES, environment
    assert_equal [["SELECT 1", {markdown: true}], {connection: :connection}], executed
  end
end
