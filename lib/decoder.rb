require_relative 'alphabet'

class Decoder

  def initialize(braille)
    @should_capitalize_next = false
    @output = []
    @alphabet = Alphabet.new
    @braille = braille
    @lines = braille.split("\n")
    @n = lines[0].length
    @as_one_line = lines.join
  end

  def decode
    decode_runner
    output.join
  end

  private

  attr_reader :output, :alphabet, :braille, :lines, :n, :as_one_line

  def decode_runner
    (0..(n-1)).each_slice(2) do |column_offset|
      braille_character = build_decoded_character(column_offset)
      decoded_braille = alphabet.braille_letter_hash.key(braille_character.join)
      build_output(decoded_braille)
    end
  end

  def build_output(decoded_braille)
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

  def build_decoded_character(column_offset)
    braille_character = []
    (0..2).each do |row_offset|
      braille_character << as_one_line[(row_offset * n) + column_offset[0]]
      braille_character << as_one_line[(row_offset * n) + column_offset[1]]
    end
    braille_character
  end
end
