require "test_helper"

class TestTaql < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Taql::VERSION
  end
end
