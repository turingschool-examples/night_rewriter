require './test/test_helper'
require './lib/translate_to_braille'

class BrailleTranslatorTest < Minitest::Test

  def translator
    @translator ||= TranslateToBraille.new
  end

  def test_can_lookup
    assert_equal ".", translator.lookup("a", 4)
  end

  def test_postion
    assert_equal ".", translator.lookup(:capitalize, 0) 
  end

end
