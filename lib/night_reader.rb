require_relative 'alphabet'

class NightReader
  attr_reader :alphabet, :output

  def initialize
    @alphabet = Alphabet.new
    @output = []
  end

  def encode_from_braille(braille)
    lines = braille.split("\n")
    n = lines[0].length
    as_one_line = lines.join
    @should_capitalize_next = false

    (0..(n-1)).each_slice(2) do |column_offset|
      braille_character = []
      offset_row(column_offset, braille_character, n, as_one_line)
      capital(braille_character)
    end

    output.join
  end

  def capital(braille_character)
    if decoded_braille(braille_character) == :capitalize
      @should_capitalize_next = true
    elsif @should_capitalize_next
      output << decoded_braille(braille_character).upcase
      @should_capitalize_next = false
    else
      output << decoded_braille(braille_character)
      @should_capitalize_next = false
    end
  end

  def offset_row(column_offset, braille_character, n,as_one_line)
    (0..2).each do |row_offset|
      braille_character << as_one_line[(row_offset * n) + column_offset[0]]
      braille_character << as_one_line[(row_offset * n) + column_offset[1]]
    end
  end

  def decoded_braille(braille_character)
    alphabet.braille_letter_hash.key(braille_character.join)
  end
end
