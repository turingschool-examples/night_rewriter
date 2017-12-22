require_relative 'alphabet'
require 'pry'

class NightWriter

  def initialize
    @alphabet = Alphabet.new
  end

  def lookup(character, position)
    @alphabet.braille_letter_hash[character].chars[position]
  end
  
  def lookup_whole(character)
    @alphabet.braille_letter_hash[character]
  end
  
  def capitalize(letter)
    cap = lookup_whole(:capitalize).scan(/../)
    letter = cap.zip(letter)
    letter = letter.map {|let| let.join}
  end
  
  def map_chars(plain)
    plain.chars.map do |char|
      letter = lookup_whole(char.downcase).scan(/../)
      if char == char.upcase
        letter = capitalize(letter)
      end
      letter
    end
  end

  def encode_to_braille(plain)
    output = ["","",""]
    raw_braille = map_chars(plain)
    raw_braille.each do |raw|
      output[0] += raw[0]
      output[1] += raw[1]
      output[2] += raw[2]
    end
    output.join("\n")
  end
  
  def find_caps(rows)
    next_cap = false
    the_return = rows.map do |row|
      letter = @alphabet.braille_letter_hash.key(row.flatten.join)
      if letter == :capitalize
        next_cap = true
        letter = nil
      else
        if next_cap == true
          letter = letter.upcase
          next_cap = false
        end
      end
      letter
    end
  end

  def encode_from_braille(braille)
    lines = braille.split("\n")
    char_pieces = lines.map {|line| line.scan(/../)}
    three_rows = char_pieces[0].zip(char_pieces[1]).zip(char_pieces[2])
    the_return = find_caps(three_rows)
    the_return.compact! if the_return.class == Array 
    the_return.join
    # n = lines[0].length
    # m = 3
    # as_one_line = lines.join
    # output = []
    # should_capitalize_next = false
    # 
    # (0..(n-1)).each_slice(2) do |column_offset|
    # 
    #   braille_character = []
    #   (0..(m-1)).each do |row_offset|
    #     braille_character << as_one_line[(row_offset * n) + column_offset[0]]
    #     braille_character << as_one_line[(row_offset * n) + column_offset[1]]
    #   end
    # 
    #   decoded_braille = @alphabet.braille_letter_hash.key(braille_character.join)
    # 
    #   if decoded_braille == :capitalize
    #     should_capitalize_next = true
    #   elsif should_capitalize_next
    #     output << decoded_braille.upcase
    #     should_capitalize_next = false
    #   else
    #     output << decoded_braille
    #     should_capitalize_next = false
    #   end
    # end
    # output.join
  end
end

