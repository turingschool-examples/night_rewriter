require_relative 'alphabet'
require 'pry'

class NightWriter

  def initialize
    @alphabet = Alphabet.new
    @output = []
  end

  def lookup(character, char_1, char_2)
    @alphabet.braille_letter_hash[character].chars[char_1..char_2]
  end

  def new_lookup(character)
    @alphabet.braille_letter_hash[character]
  end

  def encode_to_braille(plain)
    encode_top_line(plain)
    encode_mid_line(plain)
    encode_bot_line(plain)
    encoded = @output.join
  end


  def encode_from_braille(braille)
    lines = braille.split("\n")
    # binding.pry
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

  def encode_top_line(plain)
    encode(plain, 0, "..")
  end

  def encode_mid_line(plain)
    encode(plain, 2, "..")
  end

  def encode_bot_line(plain)
    encode(plain, 4, ".0")
  end

  def encode(plain, offset, capital_chars)
    plain.chars.each do |letter|
      @output << capital_chars if letter == letter.upcase && letter != " "
      @output << new_lookup(letter.downcase).slice(offset, 2)
    end
    @output << "\n"
  end

end
