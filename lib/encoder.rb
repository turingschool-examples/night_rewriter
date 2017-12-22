require_relative 'alphabet'
require_relative 'lookup_module'

class Encoder

  include Lookup

  def initialize
    @alphabet = Alphabet.new
  end

  def encode_to_braille(plain)
    output = []
    [0,2,4].each do |offset|
      plain.chars.each do |letter|
        if letter == letter.upcase
          output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
          letter = letter.downcase
        end
        output << lookup(letter, offset) << lookup(letter, offset + 1)
      end
      output << "\n"
    end
    encoded = output.join
  end

end
