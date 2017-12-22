require_relative 'alphabet'
require_relative 'encoder'

class NightWriter

  def initialize
    @alphabet = Alphabet.new
  end

  def lookup(character, position)
    @alphabet.braille_letter_hash[character].chars[position]
  end

  def encode(plain, braille)
    #run the encode from plain
    #run the encode to braille
  end

end
