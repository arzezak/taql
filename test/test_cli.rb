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
end
