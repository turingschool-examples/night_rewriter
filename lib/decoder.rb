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

    (0..(n-1)).each_slice(2) do |column_offset|
      braille_character = []
      (0..2).each do |row_offset|
        braille_character << braille_assembler(row_offset, column_offset[0], n)
        braille_character << braille_assembler(row_offset, column_offset[1], n)
      end
      decoded_braille = braille_decoder(braille_character.join)
      capital_check(decoded_braille)
    end
    @output.join
  end

  def braille_assembler(row, column, n)
    @lines.join[(row * n) + column]
  end

  def braille_decoder(braille_string)
    @alphabet.braille_letter_hash.key(braille_string)
  end

  def capital_check(decoded_braille)
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

end
