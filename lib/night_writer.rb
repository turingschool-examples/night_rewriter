require_relative 'alphabet'
require 'pry'

class NightWriter

  def initialize
    @alphabet = Alphabet.new
  end

  def lookup(character, position)
    # start_range = position
    # @alphabet.braille_letter_hash[character.downcase][start_range..start_range + 1]
    @alphabet.braille_letter_hash[character].chars[position]
  end

  def brail_line(character, position)
    start_range = position
    @alphabet.braille_letter_hash[character.downcase][start_range..start_range + 1]
  end

  def encode_to_braille(plain)
    output = []
    [0,2,4].each do |offset|
      plain.chars.each do |letter|
        if letter == letter.upcase
          # output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
          output << brail_line(:capitalize, offset)
          letter = letter.downcase
        end
        # output << lookup(letter, offset) << lookup(letter, offset + 1)
        output << brail_line(letter, offset)
      end
      output << "\n"
    end
    output.join
  end

  # def encode_to_braille(plain)
  #   output = {1=>"", 2=> "", 3=> ""}
  #   plain_split = plain.split("")
  #   3.times do |i|
  #     plain_split.each do |letter|
  #       output[i] += lookup(letter, i)
  #     end
  #   end
  #   output
  # end

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
