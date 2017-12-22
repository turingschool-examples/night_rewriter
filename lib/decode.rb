require_relative 'alphabet'
require 'pry'

class EncodeFromBraille
  attr_reader :output
  def initialize
    @alphabet = Alphabet.new
    @output = []
  end

  def encode_from_braille(braille)
    lines = braille.split("\n")
    n = lines[0].length
    should_capitalize_next = false

    (0..(n-1)).each_slice(2) do |column_offset|

      braille_character = get_braille_character(column_offset, lines, n)

      decoded_braille = @alphabet.braille_letter_hash.key(braille_character.join)

      if decoded_braille == :capitalize
        should_capitalize_next = true
      elsif should_capitalize_next
        output << decoded_braille.upcase
        should_capitalize_next = false
      else
        output << decoded_braille
        should_capitalize_next = false
      end
    end
    output.join
  end

  private

  def get_braille_character(column_offset, lines, n)
    m = 3
    as_one_line = lines.join
    braille_character = []
    (0..(m-1)).each do |row_offset|
      braille_character << as_one_line[(row_offset * n) + column_offset[0]]
      braille_character << as_one_line[(row_offset * n) + column_offset[1]]
    end
    braille_character
  end
end
