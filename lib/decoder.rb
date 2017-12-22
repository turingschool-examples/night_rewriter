require_relative 'alphabet'

class Decoder

  attr_reader :input,
              :n,
              :output

  def initialize(input)
    @input = input
    @n = nil
    @output = []
    @alphabet = Alphabet.new
  end

  def decode
    as_one_line = prepare_lines
    append_characters(as_one_line)
    output.join
  end

  def append_characters(as_one_line)
    should_capitalize_next = false
    (0..(n-1)).each_slice(2) do |column_offset|
      braille_character = get_braille_character(as_one_line, column_offset)
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
  end

  def get_braille_character(as_one_line, column_offset)
    braille_character = []
    (0..2).each do |row_offset|
      braille_character << as_one_line[(row_offset * n) + column_offset[0]]
      braille_character << as_one_line[(row_offset * n) + column_offset[1]]
    end
    braille_character
  end

  def get_lines(braille)
    braille.split("\n")
  end

  def set_line_length(lines)
    @n = lines[0].length
  end

  def prepare_lines
    lines = get_lines(input)
    set_line_length(lines)
    lines.join
  end

end
