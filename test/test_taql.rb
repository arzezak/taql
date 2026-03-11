require "test_helper"

class TestTaql < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Taql::VERSION
  end

  def test_that_it_outputs_a_table
    query = "SELECT name, age FROM users"
    results = [
      {"name" => "Alice", "age" => 30},
      {"name" => "Bob", "age" => 25},
      {"name" => "Charlie", "age" => 35}
    ]
    connection = Minitest::Mock.new
    connection.expect(:execute, results, [query])
    table = Taql::Table.new(results)

    stdout, _stderr = capture_io do
      Taql.execute(query, {}, connection: connection)
    end

    assert_equal table.print, stdout.chomp
  end

  def test_that_it_raises_without_connection
    assert_raises(RuntimeError) { Taql.execute("SELECT 1") }
  end
end
