require "test_helper"

class TestList < Minitest::Test
  def test_vertical_output
    list = Taql::List.new([
      {"name" => "Alice", "age" => 30},
      {"name" => "Bob", "age" => 25}
    ], terminal_width: 40)

    result = list.print

    assert_includes result, "NAME | Alice"
    assert_includes result, " AGE | 25"
  end

  def test_single_record
    list = Taql::List.new([
      {"name" => "Alice", "age" => 30}
    ], terminal_width: 40)

    result = list.print

    assert_includes result, "NAME | Alice"
    assert_includes result, " AGE | 30"
  end

  def test_divider_fills_terminal_width
    list = Taql::List.new([
      {"name" => "Alice"}
    ], terminal_width: 40)

    lines = list.print.lines.map(&:chomp)

    assert_equal 40, lines.first.length
    assert_equal 40, lines.last.length
  end

  def test_trailing_separator
    list = Taql::List.new([
      {"name" => "Alice"}
    ], terminal_width: 40)

    last_line = list.print.lines.last.chomp

    assert_match(/\A-+\z/, last_line)
  end

  def test_renders_nothing_when_empty
    list = Taql::List.new([])

    assert_nil list.print
  end

  def test_default_divider_without_terminal_width
    list = Taql::List.new([
      {"name" => "Alice"}
    ])

    result = list.print

    assert_match(/\A-+\n/, result)
  end

  def test_headers_are_right_padded
    list = Taql::List.new([
      {"name" => "Alice", "email" => "alice@example.com"}
    ], terminal_width: 40)

    result = list.print

    assert_includes result, " NAME | Alice"
    assert_includes result, "EMAIL | alice@example.com"
  end
end
