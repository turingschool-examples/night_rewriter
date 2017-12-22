require_relative 'alphabet'
require_relative 'encoder'
require_relative 'decoder'

class NightWriter

  def initialize
    @alphabet = Alphabet.new
  end

  def encode_to_braille(plain)
    encoder = Encoder.new(plain)
    encoder.encode
  end

  def encode_from_braille(braille)
    decoder = Decoder.new(braille)
    decoder.decode
  end
end
