require_relative 'alphabet'
require 'pry'


class Decoder

  def initialize
    @alphabet = Alphabet.new
  end

  def decode(braille)
    lines = braille.split("\n")
    output = []
    (lines[0].length / 2).times do
      letter = lines[0].slice!(0,2) + lines[1].slice!(0,2) + lines[2].slice!(0,2)
      output << @alphabet.braille_letter_hash.key(letter)
    end
    format_braille(output)
  end

  def format_braille(array)
    caps = false
    output = []
    array.each do |letter|
      if letter == :capitalize
        caps = true
      elsif caps
        output << letter.upcase
        caps = false
      else
        output << letter
      end
    end
    output.reduce(:+)
  end

end
