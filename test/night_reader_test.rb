require './test/test_helper'
require './lib/night_reader'
require './lib/alphabet'

class NightWriterTest < Minitest::Test

  def reader
    @reader ||= NightReader.new
  end

  def test_decodes_letter
    assert_equal "a", reader.encode_from_braille("0.\n..\n..\n")
  end

  def test_decodes_cap_letter
    assert_equal "A", reader.encode_from_braille("..0.\n....\n.0..\n")
  end

  def test_decodes_message
    assert_equal "Hello World",reader.encode_from_braille("..0.0.0.0.0........00.0.0.00\n..00.00.0..0......00.0000..0\n.0....0.0.0..0...0.00.0.0...\n")
  end
end


