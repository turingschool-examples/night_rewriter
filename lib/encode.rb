require_relative 'alphabet'

class EncodeToBraille
  attr_reader :output
  def initialize
    @alphabet = Alphabet.new
    @output = []
  end

  def lookup(character, position)
    @alphabet.braille_letter_hash[character].chars[position]
  end

  def encode_to_braille(plain)
    [0,2,4].each do |offset|
      add_to_output(plain, offset)
      output << "\n"
    end
    encoded = output.join
  end

  private

  def add_to_output(plain, offset)
    plain.chars.each do |letter|
      if letter == letter.upcase
        output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
        letter = letter.downcase
      end
      output << lookup(letter, offset) << lookup(letter, offset + 1)
    end
  end
end
