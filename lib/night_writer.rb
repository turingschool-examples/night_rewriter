require_relative 'alphabet'

class NightWriter

  def initialize
    @alphabet = Alphabet.new
  end

  def encode_to_braille(plain)
    braille_chars = plain.chars.map do |letter|
      if letter == letter.upcase
        return lookup(:capitalize) + lookup(letter.downcase)
      end
      return lookup(letter)
    end
    braille_chars.join
  end

  def decode_from_braille(braille)
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

  private

  def lookup(character)
    @alphabet.braille_letter_hash[character]
  end
end
