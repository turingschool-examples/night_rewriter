require './test/test_helper'
require './lib/night_writer'
require './lib/alphabet'
require './lib/converter'
require './lib/lookup'
require 'pry'
class NightWriterTest < Minitest::Test

  def writer
    @writer ||= NightWriter.new
  end

  def test_can_lookup
    assert_equal ".", Lookup.lookup("a", 4)
  end

  def test_postion
    assert_equal ".", Lookup.lookup(:capitalize, 0)
  end

  def test_can_encode_a_letter
    assert_equal "0.\n..\n..\n", writer.converter.encode_to_braille("a")
  end

  def test_can_encode_cap_letter
    assert_equal "..0.\n....\n.0..\n", writer.encode_to_braille("A")
  end

  def test_decodes_letter
    assert_equal "a", writer.encode_from_braille("0.\n..\n..\n")
  end

  def test_decodes_cap_letter
    assert_equal "A", writer.encode_from_braille("..0.\n....\n.0..\n")
  end

  def test_encodes_message
    assert_equal "..0.0.0.0.0........00.0.0.00\n..00.00.0..0......00.0000..0\n.0....0.0.0..0...0.00.0.0...\n", writer.encode_to_braille("Hello World")
  end

  def test_decodes_message
    assert_equal "Hello World",writer.encode_from_braille("..0.0.0.0.0........00.0.0.00\n..00.00.0..0......00.0000..0\n.0....0.0.0..0...0.00.0.0...\n")
  end
end

