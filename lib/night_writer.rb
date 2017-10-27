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
    # output = []
    # [0,2,4].each do |offset| #loop through offset 0,2,4
    #   plain.chars.each do |letter| #string to array of characters
    #     if letter == letter.upcase #returns true if letter is uppercase
    #       output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1) #push capital character + offset, ca
    #       letter = letter.downcase
    #     end
    #     output << lookup(letter, offset) << lookup(letter, offset + 1)
    #   end
    #   output << "\n"
    # end
    # encoded = output.join
    # offsets = [0,1,2,3,4,5]
    plain.split(' ').map {|word|
      convert(word).flatten.join('')
    }.flatten.join('')
  end

  def convert(word)
    word.split('').map { |letter|
      insert_new_line(@alphabet.braille_letter_hash[letter].split(''), word).flatten
    }
  end

  def insert_new_line(arr, word)
    a = arr.each_slice(2).to_a
    a.insert(1, "\n")
    a.insert(3, "\n")
    a.insert(-1, "\n")
  end

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
