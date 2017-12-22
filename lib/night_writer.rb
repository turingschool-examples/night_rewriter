require_relative 'alphabet'

class NightWriter

  def initialize
    @alphabet = Alphabet.new
  end

  # MASTER METHOD - ENCODE

  def encode_to_braille(plain)
    output = []
    build_lines(plain, output)
    output.join
  end

  # encode to braille

  def build_lines(plain, output)
    [0,2,4].each do |offset|
      convert(plain, offset, output)
    end
  end

  def convert(plain, offset, output)
    append_line(plain, offset, output)
    append_line_break(output)
  end

  def append_line_break(output)
    output << "\n"
  end

  def append_line(plain, offset, output)
    plain.chars.each do |letter|
      letter = capitalize(letter, offset, output) if letter == letter.upcase
      append_braille_letter(letter, offset, output)
    end
  end

  def append_braille_letter(letter, offset, output)
    output << @alphabet.lookup(letter, offset) << @alphabet.lookup(letter, offset + 1)
  end

  def capitalize(letter, offset, output)
    output << @alphabet.lookup(:capitalize, offset) << @alphabet.lookup(:capitalize, offset + 1)
    letter.downcase
  end

  # MASTER METHOD - DECODE

  def encode_from_braille(braille)
    lines = braille.split("\n")
    n = lines[0].length
    m = 3
    as_one_line = lines.join
    output = []
    should_capitalize_next = false

    (0..(n-1)).each_slice(2) do |column_offset|

      braille_character = []
      (0..(m-1)).each do |row_offset|
        braille_character << as_one_line[(row_offset * n) + column_offset[0]]
        braille_character << as_one_line[(row_offset * n) + column_offset[1]]
      end

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
end
