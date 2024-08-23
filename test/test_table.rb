require "test_helper"

class TestTable < Minitest::Test
  def setup
    @io = StringIO.new
    @table = Taql::Table.new([
      {"name" => "Alice", "age" => 30},
      {"name" => "Bob", "age" => 25},
      {"name" => "Charlie", "age" => 35}
    ], io: @io)
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

    assert_equal(output, @io.string)
  end

  def test_that_it_returns_headers
    headers = ["name", "age"]

    assert_equal headers, @table.headers
  end

  def test_that_it_returns_rows
    rows = {
      "name" => ["Alice", "Bob", "Charlie"],
      "age" => [30, 25, 35]
    }

    assert_equal rows, @table.rows
  end

  def test_that_it_returns_rows_with_headers
    rows_with_headers = {
      "name" => ["name", "Alice", "Bob", "Charlie"],
      "age" => ["age", 30, 25, 35]
    }

    assert_equal rows_with_headers, @table.rows_with_headers
  end

  def test_that_it_outputs_separators
    assert_equal "+---------+-----+", @table.separator
  end

  def test_rows_max_length
    rows_max_length = {
      "name" => 7,
      "age" => 3
    }

    assert_equal rows_max_length, @table.rows_max_length
  end

  def test_that_it_outputs_formatted_headers
    assert_equal "| NAME    | AGE |", @table.formatted_headers
  end

  def test_that_it_returns_formatted_entries
    formatted_entries = [
      "| Alice   | 30  |",
      "| Bob     | 25  |",
      "| Charlie | 35  |"
    ]

    assert_equal formatted_entries, @table.formatted_entries
  end
end
