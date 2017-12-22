require 'pry'

module Encode
  def encode(braille)
    #lines = split_line(braille)
    #n = lines[0].length
    #m = 3
    #as_one_line = lines.join
    output = []
    #should_capitalize_next = false

    #(0..(n-1)).each_slice(2) do |column_offset|
      #braille_character = []
      #(0..(m-1)).each do |row_offset|
        #braille_character << as_one_line[(row_offset * n) + column_offset[0]]
        #braille_character << as_one_line[(row_offset * n) + column_offset[1]]
      #end
      #decoded_braille = braille_lookup(braille_character.join)
      decoded_braille = braille_lookup(parse_braille(braille))

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
    output.join
  end

 

  def split_line(braille)
    braille.split("\n")
  end

  def braille_lookup(braille_character)
    @alphabet.braille_letter_hash.key(braille_character)
  end

  def parse_braille(braille)
    lines = split_line(braille)
    n = lines[0].length
    m = 3
    as_one_line = lines.join
    braille_character = []

    (0..(n-1)).each_slice(2) do |column_offset|
      #braille_character = []
      (0..(m-1)).each do |row_offset|
        braille_character << as_one_line[(row_offset * n) + column_offset[0]]
        braille_character << as_one_line[(row_offset * n) + column_offset[1]]
      end
    end
    return braille_character.join
  end

  def capitalize?
    if decoded_braille == :capitalize
      return true
      #should_capitalize_next = true
    #elsif should_capitalize_next
      #output << decoded_braille.upcase
      #should_capitalize_next = false
    else
      return false
      #output << decoded_braille
      #should_capitalize_next = false
    end
  end

end
