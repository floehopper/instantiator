require "test_helper"
require "instantiator"

class MethodInvocationSinkTest < Test::Unit::TestCase

  include Instantiator

  def setup
    @sink = MethodInvocationSink.new
  end

  def test_should_return_instance_of_string
    assert_instance_of String, @sink.to_str
  end

  def test_should_return_instance_of_fixnum
    assert_instance_of Fixnum, @sink.to_int
  end

  def test_should_return_instance_of_array
    assert_instance_of Array, @sink.to_ary
  end

  def test_should_return_instance_of_hash
    assert_instance_of Hash, @sink.to_hash
  end
end