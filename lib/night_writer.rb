require_relative 'alphabet'
require 'pry'

class NightWriter

  def initialize
    @alphabet = Alphabet.new
  end

  def lookup(character, position)
    @alphabet.braille_letter_hash[character].chars[position]
  end

  def encode_to_braille(plain)
    output = []
    create_2_by_3_grid(output, plain)
    output.join
  end

  def encode_from_braille(braille)
    lines = braille.split("\n")
    n = lines[0].length
    m = 3
    as_one_line = lines.join
    output = []
    should_capitalize_next = false
    output = set_output(n, m, as_one_line, output, should_capitalize_next)
    output.join
  end

  private

    def create_braille_character(column_offset, n, m, as_one_line)
      braille_character = []
      (0..(m-1)).each do |row_offset|
        braille_character << as_one_line[(row_offset * n) + column_offset[0]]
        braille_character << as_one_line[(row_offset * n) + column_offset[1]]
      end
      braille_character
    end

    def capitalize_letter(decoded_braille, should_capitalize_next, output)
      if decoded_braille == :capitalize
        should_capitalize_next = true
      elsif should_capitalize_next
        output << decoded_braille.upcase
        should_capitalize_next = false
      else
        output << decoded_braille
      end
      [should_capitalize_next, output]
    end

    def set_output(n, m, as_one_line, output, should_capitalize_next)
      (0..(n-1)).each_slice(2) do |column_offset|
        braille_character = create_braille_character(column_offset, n, m, as_one_line)
        decoded_braille = @alphabet.braille_letter_hash.key(braille_character.join)
        capitalize_letter = capitalize_letter(decoded_braille, should_capitalize_next, output)
        should_capitalize_next = capitalize_letter[0]
        output = capitalize_letter[1]
      end
      output
    end

    def add_braille_to_output_array(output,offset, plain)
      plain.chars.each do |letter|
        if letter == letter.upcase
          add_capitalization(output, offset)
          letter = letter.downcase
        end
        output << lookup(letter, offset) << lookup(letter, offset + 1)
      end
      output
    end

    def add_capitalization(output, offset)
      output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
    end

    def create_2_by_3_grid(output, plain)
      [0,2,4].each do |offset|
        output = add_braille_to_output_array(output, offset, plain)
        output << "\n"
      end
    end
end
