require "test_helper"

class TestTaql < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Taql::VERSION
  end

  def test_that_it_outputs_a_table
    query = "select name, age from users"
    results = [
      {"name" => "Alice", "age" => 30},
      {"name" => "Bob", "age" => 25},
      {"name" => "Charlie", "age" => 35}
    ]
    connection = Minitest::Mock.new
    connection.expect(:execute, results, [query])
    expected_output = Taql::Table.new(results).print

    assert_output(expected_output) do
      Taql.execute(query, connection: connection)
    end
  end
end
