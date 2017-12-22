require_relative 'alphabet'
require_relative 'lookup_module'

class Encoder

  include Lookup

  def initialize
    @alphabet = Alphabet.new
    @output =[]
  end

  def encode_to_braille(plain)
    [0,2,4].each do |offset|
      plain.chars.each do |letter|
        check_letter(letter, offset)
      end
      @output << "\n"
    end
    encoded = @output.join
  end

  def check_letter(letter, offset)
    if letter == letter.upcase
      @output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
      letter = letter.downcase
    end
    @output << lookup(letter, offset) << lookup(letter, offset + 1)
  end

end
