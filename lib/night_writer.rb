require_relative 'alphabet'

class NightWriter
  attr_reader :alphabet

  def initialize
    @alphabet = Alphabet.new
  end

  def lookup(character, position)
    alphabet.braille_letter_hash[character].chars[position]
  end

  def encode_to_braille(plain)
    output = []
    [0,2,4].each do |offset|
      plain_chars(plain, output, offset)
      output << "\n"
    end
    output.join
  end

  def plain_chars(plain, output, offset)
    plain.chars.each {|letter| if_block(letter, output, offset)}
  end

  def if_block(letter, output, offset)
    if letter == letter.upcase
      output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
      letter = letter.downcase
    end
    output << lookup(letter, offset) << lookup(letter, offset + 1)
  end

end
