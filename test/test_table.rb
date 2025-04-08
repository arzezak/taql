require "test_helper"

class TestTable < Minitest::Test
  def setup
    @table = Taql::Table.new([
      {"name" => "Alice", "age" => 30},
      {"name" => "Bob", "age" => 25},
      {"name" => "Charlie", "age" => 35}
    ])
  end

  def test_that_it_returns_columns
    columns = [
      ["name", "Alice", "Bob", "Charlie"],
      ["age", "30", "25", "35"]
    ]

    assert_equal columns, @table.columns
  end

  def test_that_it_returns_headers
    assert_equal ["name", "age"], @table.headers
  end

  def test_that_it_returns_rows
    rows = [
      ["name", "age"],
      ["Alice", "30"],
      ["Bob", "25"],
      ["Charlie", "35"]
    ]

    assert_equal rows, @table.rows
  end

  def test_that_it_outputs_a_table
    output = <<~OUTPUT
      +---------+-----+
      | NAME    | AGE |
      +---------+-----+
      | Alice   | 30  |
      | Bob     | 25  |
      | Charlie | 35  |
      +---------+-----+
    OUTPUT

    @table.print

    assert_output(output) { puts @table.print }
  end

  def test_that_it_renders_nothing
    empty_table = Taql::Table.new([])

    assert_output("\n") { puts empty_table.print }
  end
end
