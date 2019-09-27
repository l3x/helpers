require 'minitest/autorun'
require_relative './hello'

class HelloTest < Minitest::Test
  def test_world
    assert_equal 'world', Hello.world, "Hello.world should return a string called 'world'"
  end

  def test_flunk
    flunk "You shall not pass"
  end
end
