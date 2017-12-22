require_relative 'alphabet'
require_relative 'encoder'
require_relative 'decoder'

class NightWriter
  include Encoder

  def initialize
    @alphabet = Alphabet.new
  end

  def lookup(character, position)
    @alphabet.braille_letter_hash[character].chars[position]
  end

  def encode_to_braille(plain)
    encode(plain)
  end

  def encode_from_braille(braille)
    decoder = Decoder.new(braille)
    decoder.decode
  end
end
