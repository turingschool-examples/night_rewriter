require './test/test_helper'
require './lib/encode'
require './lib/alphabet'

class EncodeToBrailleTest < Minitest::Test
  def encode
    @encode ||= EncodeToBraille.new
  end

  def test_can_lookup
    assert_equal ".", encode.lookup("a", 4)
  end

  def test_postion
    assert_equal ".", encode.lookup(:capitalize, 0)
  end
end
