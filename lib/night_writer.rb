require_relative 'alphabet'
require_relative 'encode'
require_relative 'decode'
require 'pry'

class NightWriter

  def initialize
    @encode = EncodeToBraille.new
    @decode = EncodeFromBraille.new
  end

  def encode_to_braille(plain)
    @encode.encode_to_braille(plain)
  end

  def encode_from_braille(braille)
    @decode.encode_from_braille(braille)
  end
end

