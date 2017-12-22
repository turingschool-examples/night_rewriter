require_relative 'alphabet'
require_relative 'lookup_module'

class Decoder

  include Lookup

  def initialize
    @alphabet = Alphabet.new
    @output = []
    @should_capitalize_next = false
    @lines = []
  end

  def encode_from_braille(braille)
    @lines = braille.split("\n")
    n = @lines[0].length
    m = 3

    (0..(n-1)).each_slice(2) do |column_offset|

      braille_character = []
      (0..(m-1)).each do |row_offset|
        braille_character << @lines.join[(row_offset * n) + column_offset[0]]
        braille_character << @lines.join[(row_offset * n) + column_offset[1]]
      end

      decoded_braille = @alphabet.braille_letter_hash.key(braille_character.join)

      if decoded_braille == :capitalize
        @should_capitalize_next = true
      elsif @should_capitalize_next
        @output << decoded_braille.upcase
        @should_capitalize_next = false
      else
        @output << decoded_braille
        @should_capitalize_next = false
      end
    end
    @output.join
  end

end
