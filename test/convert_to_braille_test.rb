require './test/test_helper'
require './lib/night_writer'
require './lib/alphabet'

class ConvertToBraille < Minitest::Test

  def test_can_lookup
    convert = ConvertToBraille.new
    assert_equal ".", convert.lookup("a", 4)
  end

  def test_postion
    convert = ConvertToBraille.new
    assert_equal ".", convert.lookup(:capitalize, 0)
  end
end


