require_relative 'alphabet'

class ConvertFromBraille

  def initialize
    @alphabet = Alphabet.new
  end

  def should_capitalize_next(input)
      if input == :capitalize
        return true
      elsif should_capitalize_next
        output << decoded_braille.upcase
        return false
      else
        output << decoded_braille
        return false
      end
  end

  def character_offset(input)
    (0..(n-1)).input(2) do |column_offset|

      braille_character = []
      (0..(m-1)).each do |row_offset|
        braille_character << as_one_line[(row_offset * n) + column_offset[0]]
        braille_character << as_one_line[(row_offset * n) + column_offset[1]]
      end
      decoded_braille = @alphabet.braille_letter_hash.key(braille_character.join)
    end

  end

  def self.encode(braille)
    lines = braille.split("\n")
    n = lines[0].length
    m = 3
    as_one_line = lines.join
    output = []
    character_offset(each_slice)
    output.join
  end

end
