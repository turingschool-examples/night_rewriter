require_relative 'alphabet'


class BrailleReader

  def initialize
    @alphabet = Alphabet.new
  end

  def encode_from_braille(text)
    braille_character(text)
  end

  def text_to_lines(text)
    text.split("\n")
  end # returns each line as array with words and removes " "

  def braille_character(text)
    row_offser = 3 # rows per braille character
    num_char = line_of_text(text).length
    (0..(num_char - 1)).each_slice(2) do |column_offset|
      braille_character = []
      (0..(row_offset - 1)).each do |row_offset|
        braille_character << as_one_line[(row_offset * num_char) + column_offset[0]]
        braille_character << as_one_line[(row_offset * num_char) + column_offset[1]]
      end
    end
  end

  def line_of_text(text)
    text_to_lines(text)
    #@number_characters = text_to_lines[0].length # returns the number of characters in top line of text
    return text_to_lines.join # returns line of text
  end

  def decoded_braille(braille_character)
    output = []
    decoded_braille = @alphabet.braille_letter_hash.key(braille_character.join)
    output = upcase(decoded_braille)
    return output.join
  end

  def capitalize?(decoded_braille)
    false unless decoded_braille == :capitalize
  end

  def upcase?(decoded_braille)
    if capitalize?(decoded_braille)
      decoded_braille.upcase
    else
      decoded_braille
    end
  end
end
