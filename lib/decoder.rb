require_relative 'alphabet'
require_relative 'lookup'

class Decoder
  include Lookup
  attr_reader :alphabet, :should_capitalize_next, :m, :output

  def initialize
    @alphabet = Alphabet.new
    @should_capitalize_next = false
    @m = 3
    @output = []
  end

  def from_braille(braille)
    lines = braille.split("\n")
    n = lines[0].length
    build_slices(lines, n)
    output.join
  end

  def build_slices(lines, n)
    (0..(n-1)).each_slice(2) do |column_offset|
      braille_character = []
      get_braille_character(braille_character, column_offset, n, m, lines)
      decoded_braille = @alphabet.braille_letter_hash.key(braille_character.join)
      handle_decoded_braille(decoded_braille, output)
    end
  end

  def get_braille_character(braille_character, column_offset, n, m, lines)
    as_one_line = lines.join
    (0..(m-1)).each do |row_offset|
      braille_character << as_one_line[(row_offset * n) + column_offset[0]]
      braille_character << as_one_line[(row_offset * n) + column_offset[1]]
    end
  end

  def handle_decoded_braille(decoded_braille, output)
    if decoded_braille == :capitalize
      @should_capitalize_next = true
    elsif @should_capitalize_next
      output << decoded_braille.upcase
      @should_capitalize_next = false
    else
      output << decoded_braille
      @should_capitalize_next = false
    end
  end
end


