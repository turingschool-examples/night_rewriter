require_relative 'alphabet'
require_relative 'lookup'

class Encoder
  include Lookup
  attr_reader :alphabet

  def initialize
    @alphabet = Alphabet.new
  end

  def encode_to_braille(plain)
    output = []
    [0,2,4].each do |offset|
      encode_letter(plain, offset, output)
      output << "\n"
    end
    encoded = output.join
  end

  def encode_letter(plain, offset, output)
    plain.chars.each do |letter|
      handle_case(letter, output, offset)
    end
  end

  def handle_case(letter, output, offset)
    if letter == letter.upcase
      output << Lookup.lookup(:capitalize, offset) << Lookup.lookup(:capitalize, offset + 1)
      letter = letter.downcase
    end
    output << Lookup.lookup(letter, offset) << Lookup.lookup(letter, offset + 1)
  end
end

