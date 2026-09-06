require "test_helper"

class TestTaql < Minitest::Test
  RESULTS = [
    {"name" => "Alice", "age" => 30},
    {"name" => "Bob", "age" => 25},
    {"name" => "Charlie", "age" => 35}
  ].freeze

  def teardown
    Taql.default_connection = nil
  end

  def test_that_it_has_a_version_number
    refute_nil ::Taql::VERSION
  end

  def test_that_it_outputs_a_table
    query = "SELECT name, age FROM users"
    connection = Minitest::Mock.new
    connection.expect(:execute, RESULTS, [query])
    table = Taql::Table.new(RESULTS)

    stdout, _stderr = capture_io do
      Taql.execute(query, {}, connection: connection)
    end

    assert_equal table.print, stdout.chomp
  end

  def test_that_it_outputs_nothing_without_results
    connection = Minitest::Mock.new
    connection.expect(:execute, [], ["SELECT 1"])

    assert_silent { Taql.execute("SELECT 1", {}, connection: connection) }
  end

  def test_that_it_outputs_a_list_when_table_is_too_wide
    connection = Minitest::Mock.new
    connection.expect(:execute, RESULTS, ["SELECT 1"])
    list = Taql::List.new(RESULTS, terminal_width: 10)

    stdout, _stderr = Taql.stub(:terminal_width, 10) do
      capture_io { Taql.execute("SELECT 1", {}, connection: connection) }
    end

    assert_equal list.print, stdout.chomp
  end

  def test_that_markdown_ignores_terminal_width
    connection = Minitest::Mock.new
    connection.expect(:execute, RESULTS, ["SELECT 1"])
    table = Taql::Table.new(RESULTS, markdown: true)

    stdout, _stderr = Taql.stub(:terminal_width, 10) do
      capture_io { Taql.execute("SELECT 1", {markdown: true}, connection: connection) }
    end

    assert_equal table.print, stdout.chomp
  end

  def test_that_it_uses_the_default_connection
    connection = Minitest::Mock.new
    connection.expect(:execute, [], ["SELECT 1"])
    Taql.default_connection = -> { connection }

    Taql.execute("SELECT 1")

    assert_mock connection
  end

  def test_that_it_raises_without_connection
    assert_raises(RuntimeError) { Taql.execute("SELECT 1") }
  end

  def test_that_terminal_width_reads_the_console
    console = Struct.new(:winsize).new([24, 80])

    IO.stub(:console, console) do
      assert_equal 80, Taql.send(:terminal_width)
    end
  end

  def test_that_terminal_width_is_nil_without_console
    IO.stub(:console, nil) do
      assert_nil Taql.send(:terminal_width)
    end
  end

  def test_that_it_leases_an_active_record_connection
    pool = Struct.new(:lease_connection).new(:leased)

    with_connection_pool(pool) do
      assert_equal :leased, Taql.active_record_connection
    end
  end

  def test_that_it_falls_back_to_checking_out_a_connection
    pool = Struct.new(:connection).new(:checked_out)

    with_connection_pool(pool) do
      assert_equal :checked_out, Taql.active_record_connection
    end
  end

  private

  def with_connection_pool(pool)
    base = Module.new { define_singleton_method(:connection_pool) { pool } }
    active_record = Module.new.tap { |mod| mod.const_set(:Base, base) }
    Object.const_set(:ActiveRecord, active_record)
    yield
  ensure
    Object.send(:remove_const, :ActiveRecord)
  end
end
