require_relative 'alphabet'
require_relative 'encoder'
require_relative 'decoder'
require 'pry'

class NightWriter

  def initialize
    @encoder = Encoder.new
    @decoder = Decoder.new
  end

  def encode_to_braille(plain)
    @encoder.encode(plain)
  end

  def lookup(letter)
    @encoder.lookup(letter)
  end

  def encode_from_braille(braille)
    @decoder.decode(braille)
  end

end
