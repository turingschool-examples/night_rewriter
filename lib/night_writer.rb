require_relative 'alphabet'
require 'pry'

class NightWriter

  def initialize
    @alphabet = Alphabet.new
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
    the_return = split(lines)
    the_return.compact! if the_return.class == Array 
    the_return.join
  end
  
  def split(lines)
    char_pieces = lines.map {|line| line.scan(/../)}
    three_rows = char_pieces[0].zip(char_pieces[1]).zip(char_pieces[2])
    the_return = find_caps(three_rows)
  end
end

