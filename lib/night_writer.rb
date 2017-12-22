require_relative 'alphabet'
require_relative 'encoder'
require_relative 'decoder'

class NightWriter

  include Encoder
  include Decoder

  def initialize
    @alphabet = Alphabet.new
  end

  def lookup(character, position)
    @alphabet.braille_letter_hash[character].chars[position]
  end

end
