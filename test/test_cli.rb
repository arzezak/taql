require "test_helper"

class TestCli < Minitest::Test
  def test_that_it_parses_queries
    ARGV.replace(["SELECT * FROM users"])

    cli = Taql::Cli.new(ARGV)

    assert_equal "SELECT * FROM users", *cli.query
    assert_equal false, cli.options[:markdown]
  end

  def test_that_it_parses_options
    ARGV.replace(["--markdown", "SELECT * FROM users"])

    cli = Taql::Cli.new(ARGV)

    assert_equal "SELECT * FROM users", *cli.query
    assert_equal true, cli.options[:markdown]
  end
end
