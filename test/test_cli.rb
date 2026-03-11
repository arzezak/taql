require "test_helper"

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
end
