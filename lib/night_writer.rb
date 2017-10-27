require_relative 'alphabet'
require 'pry'

class NightWriter

  attr_accessor :alphabet

  def initialize
    @alphabet = Alphabet.new
  end

  def lookup(character, position)
    @alphabet.braille_letter_hash[character].chars[position]
  end

  def encode_to_braille(plain)
    output = []
    [0,2,4].each do |offset|
      plain.chars.each do |letter|
        if letter == letter.upcase
          output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
          letter = letter.downcase
        end
        output << lookup(letter, offset) << lookup(letter, offset + 1)
      end
      output << "\n"
    end
    encoded = output.join
  end


  def into_array(input)
    break_text = input.split
    split_character = break_text.map do |characters|
      characters.split("")
    end
    split_character
  end

  def encode_from_braille(braille)
    top, middle, bottom = into_array(braille)
    new_arr = []
    until top.empty?
      new_arr << [top.shift(2).join, middle.shift(2).join, bottom.shift(2).join]
    end
    @final =  new_arr.map do |word|
      result = []
      first = alphabet.to_english(word)
    end
    @final.join("")
  end
end

t = NightWriter.new
puts t.encode_to_braille("hihfishfi hifhd")
