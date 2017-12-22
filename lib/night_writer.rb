require_relative 'alphabet'
require_relative 'encode'
require 'pry'

class NightWriter

  include Encode

  def initialize
    @alphabet = Alphabet.new
  end

  def encode_to_braille(plain)
    output = []
    [0,2,4].each do |offset|
      plain.chars.each do |letter|
        if letter == letter.upcase
          output << upcase_lookup(letter, offset)
          letter = letter.downcase
        end
        output << downcase_lookup(letter, offset)
      end
      output << "\n"
    end
    #encoded = output.join
    output.join
  end

  def encode_from_braille(braille)
    encode(braille)
    #lines = split_line(braille)
    #n = lines[0].length
    #m = 3
    #as_one_line = lines.join
    #output = []
    #should_capitalize_next = false

    #(0..(n-1)).each_slice(2) do |column_offset|
      #braille_character = []
      #(0..(m-1)).each do |row_offset|
        #braille_character << as_one_line[(row_offset * n) + column_offset[0]]
        #braille_character << as_one_line[(row_offset * n) + column_offset[1]]
      #end

      #decoded_braille = braille_lookup(braille_character.join)

      #if decoded_braille == :capitalize
        #should_capitalize_next = true
      #elsif should_capitalize_next
        #output << decoded_braille.upcase
        #should_capitalize_next = false
      #else
        #output << decoded_braille
        #should_capitalize_next = false
      #end
    #end
    #output.join
  end

  def upcase_lookup(letter, offset)
    @alphabet.lookup(:capitalize, offset) << @alphabet.lookup(:capitalize, offset + 1)
  end

  def downcase_lookup(letter, offset)
    @alphabet.lookup(letter, offset) << @alphabet.lookup(letter, offset + 1)
  end
end
