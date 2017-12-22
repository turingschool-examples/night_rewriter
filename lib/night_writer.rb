require_relative 'alphabet'

class NightWriter

  def initialize
    @alphabet = Alphabet.new
  end

  def lookup(character, position)
    @alphabet.braille_letter_hash[character].chars[position]
  end

  def encode_to_braille(plain)
    new_output = [0,2,4].map do |offset|
      output = convert(plain, offset)
      output << "\n"
    end
    new_output.join
  end

  # def encode_to_braille(plain)
  #   row_a = []
  #   row_b = []
  #   row_c = []
  #   plain.chars.each_slice(2) do |a|
  #     "row_#{a}" << a
  #   end
  # end

  def convert(plain, offset)
    output =[]
    plain.chars.each do |letter|
      if letter == letter.upcase
        output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
        letter = letter.downcase
      end
      output << lookup(letter, offset) << lookup(letter, offset + 1)
    end
    return output
  end

  def encode_from_braille(braille)
    lines = braille.split("\n")#split into 3 strings, one string for each line
    n = lines[0].length
    as_one_line = lines.join
    output = []
    should_capitalize_next = false

    (0..(n-1)).each_slice(2) do |column_offset|

      braille_character = make_character(column_offset, as_one_line, n)

      decoded_braille = @alphabet.braille_letter_hash.key(braille_character.join)

      # output = check_for_capitals(decoded_braille)

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

  # def check_for_capitals(decoded_braille)
  #   output = []
  #   if decoded_braille == :capitalize
  #     should_capitalize_next = true
  #   elsif should_capitalize_next
  #     output << decoded_braille.upcase
  #     should_capitalize_next = false
  #   else
  #     output << decoded_braille
  #     should_capitalize_next = false
  #   end
  #   return output
  # end

  def make_character(column_offset, as_one_line, n)
    braille_character = []
    (0..2).each do |row_offset|
      braille_character << as_one_line[(row_offset * n) + column_offset[0]]
      braille_character << as_one_line[(row_offset * n) + column_offset[1]]
    end
    return braille_character
  end
end
